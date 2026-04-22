= PROJECT DEFINITION AND SCOPE

*cdcIRM* (CDC Investor Relations Management) is a specialized communication platform designed to serve as a digital bridge between the Council for the Development of Cambodia and global investors. While traditional email clients are built for general-purpose correspondence, this project is engineered for "High-Velocity Investor Relations," providing a focused environment for government-to-business (G2B) interactions.

== Problem Statement and Conceptual Rationale
Currently, official correspondence is often fragmented across various platforms, leading to "context-switching" fatigue and potential delays in response times. cdcIRM addresses this by aggregating disparate email services into a single, unified, and intelligent interface. It moves beyond traditional email by integrating productivity tools such as OCR-based contact scanning and automated follow-up logic, ensuring the CDC maintains the precision expected by modern global investors.

The application focuses on three core pillars:
- *Immediacy:* Reducing the time spent on data entry and navigation.
- *Intelligence:* Assisting staff in maintaining relationships through automated reminders.
- *Integration:* Connecting directly with CDC's backend infrastructure while maintaining government-grade security protocols.

== Targeted Impact
By centralizing communication and contact management, cdcIRM aims to revolutionize the CDC's internal workflows. This project supports the organization's objective of promoting transparency and national competitiveness on the global stage, ensuring that Cambodia remains an attractive hub for sustainable development.

== Technical Architecture

The project follows a strict client-server architecture, with the mobile application and backend service developed as two independent, loosely coupled codebases that communicate exclusively through a well-defined REST API. This separation allows each layer to be maintained, tested, and deployed independently — a critical consideration in a government IT environment where change management procedures require clear boundaries between system components.

=== Backend Service
The backend is built on *NestJS*, organized as a monorepo containing three distinct packages: an *API* server that handles incoming HTTP requests and enforces business logic, a *Worker* process responsible for long-running background operations such as IMAP synchronization and push notification dispatch, and a *Shared* library that houses common type definitions, validation schemas, and utility functions consumed by both the API and the Worker. This architecture ensures that background tasks — particularly the continuous polling and listening on external mail servers — never compete with API request handling for server resources.

Authentication is implemented using *JSON Web Tokens (JWT)* with a dual-token strategy: a short-lived access token and a longer-lived refresh token. Token revocation is supported, enabling the system to forcefully terminate sessions when necessary — for example, when a device is reported lost or when a security audit demands it. Beyond simple authentication, the system implements *session trust levels*, a mechanism that assigns a confidence score to each active session based on metadata such as the device fingerprint, IP address, login time, and recent activity patterns. Sessions that fall below a configurable trust threshold can be flagged for re-authentication, adding a layer of adaptive security without burdening users with constant credential prompts.

Data persistence is managed through a relational database, with core models designed to represent mail accounts, email messages, attachments, contacts (person and company entities), access grants, and user sessions. Attachment storage is offloaded to a *CDN microservice*, ensuring that large file transfers do not degrade API performance and that files are served with appropriate caching headers for fast re-access.

=== Mobile Application
The mobile client is developed using *Flutter*, primarily targeting iOS and Android from a single codebase. Additionally, the application is compiled as a Web application specifically optimized for deployment as a *Telegram Mini App*, extending the platform's reach to officials who prefer browser-based or in-app messaging workflows.

Navigation is managed through *GoRouter*, with route-level guards that enforce authentication boundaries — unauthenticated users are restricted to onboarding and authentication screens, while authenticated users are routed directly into the application shell.

The application's state management architecture relies on a layered provider model: global providers handle cross-cutting concerns such as authentication state, API client configuration, secure token storage, and routing; feature-level providers manage the state of individual screens such as the inbox, composer, and contact detail views. Data models are generated using *freezed* with *json_serializable*, providing immutable value objects and automatic JSON serialization, which eliminates an entire class of runtime parsing errors.

A dedicated theming system supports both dark and light modes natively. Crucially, for the Telegram Mini App deployment, a specialized theme engine is implemented. This engine consumes the raw color parameters (such as background color, text color, and accent hints) passed by the Telegram WebApp API and programmatically constructs a valid, highly readable *Material Theme palette*. This ensures that when the application is launched within Telegram, it seamlessly inherits the user's personal Telegram appearance settings while strictly adhering to Material Design contrast and accessibility guidelines. The application also features deep integration with Telegram's WebApp APIs, enabling native-like interactions such as back button, haptic feedback, dynamic theme change listeners, and seamless viewport expansion.

The application is fully localized in *Khmer (KM)* and *English (EN)*, with all user-facing strings externalized and resolved at runtime based on the user's language preference.

== Functional Scope

The functional scope of cdcIRM is organized into four capability domains, each corresponding to a phase of the development timeline.

=== Identity and Access Management
This domain encompasses the complete authentication lifecycle. New users are onboarded through a structured onboarding flow that communicates the application's purpose and permissions before presenting registration and login screens. Upon authentication, the client securely stores access and refresh tokens in platform-appropriate secure storage and configures an HTTP interceptor that automatically attaches tokens to outbound requests and handles token refresh when the access token expires. On the backend, each session is tagged with trust-level metadata, and the revocation endpoint allows the system to invalidate sessions selectively.

=== Email Management
The email management domain is the core of the application. On the backend, a dedicated Worker process connects to external mail servers via the *IMAP protocol*. The initial implementation specifically targets the CDC's *cPanel-based* mail infrastructure. However, the synchronization layer is designed with a modular provider architecture — abstracting provider-specific behaviors behind a unified interface — allowing new mail servers or providers to be integrated in the future without refactoring the core mail processing logic.

New mail events fetched by the Worker are propagated to the client through a push notification pipeline built on *Firebase Cloud Messaging (FCM)*, ensuring that officials are alerted in real time — both in the foreground and when the application is in the background, with tap-to-route logic that opens the relevant email directly.

The API exposes full CRUD operations for emails: listing with server-side pagination, retrieving individual messages with HTML body rendering, composing and sending, deleting, and moving between folders. Full-text search is supported, with filters for account, date range, sender, and folder. The mobile client presents this through a multi-tab inbox shell — each tab corresponds to a configured mail account, with an additional tab for department-level shared mailboxes. The email detail screen renders HTML content within a thread view, and the compose screen integrates a rich text editor with to, cc, and bcc recipient fields. Reply and forward operations pre-populate the composer with the appropriate context. Attachments are handled through a dedicated picker and preview interface, with uploads routed to the CDN microservice and downloads streamed directly to the device.

=== Collaborative Access and Account Sharing
A distinctive feature of cdcIRM is its support for *departmental mail account sharing*. Government investor relations often require that multiple staff members access a shared inbox — for example, a general inquiries mailbox monitored by a rotating team. The backend implements an access grant system that allows administrators to assign read, write, or administrative permissions on a per-account, per-department basis. A special *BLOCKED* sentinel status is used to instantly revoke access without deleting the grant record, preserving an audit trail. The mobile client surfaces shared accounts alongside personal accounts in the inbox shell, and the permission resolution logic is verified end-to-end during a dedicated permission audit phase.

=== Contact and Entity Management
The contact management domain treats contacts as structured entities — specifically *persons* and *companies* — rather than simple address book entries. Each entity carries typed fields (name, role, organization, phone, email, address) and can be linked to any number of email messages through an indexing system, enabling staff to view the complete correspondence history associated with a given contact without manual searching.

The system also includes a *card scan* capability: the mobile client opens the device camera to capture a business card image, sends it to a backend endpoint that proxies the image to an external OCR service, and maps the recognized fields to a new or existing contact entity. The user is then presented with a confirmation screen to review, correct, and save the extracted data. Additionally, any email address appearing in a mail message can be promoted to a contact entity through a *save-as-contact* flow, reducing manual data entry during high-volume correspondence periods.

== Non-Functional Requirements

=== Security
Government-grade security is a non-negotiable constraint. All API communication occurs over HTTPS. Authentication tokens are stored in platform secure storage (Keychain on iOS, EncryptedSharedPreferences on Android, or secure Web storage for the Telegram Mini App). The session trust-level system provides behavioral anomaly detection without requiring a full multi-factor authentication infrastructure. The backend enforces rate limiting and strict input validation to mitigate abuse, and all endpoints return structured error codes that the client can map to appropriate user-facing messages without exposing internal system details.

=== Reliability and Performance
The separation of the API and Worker processes ensures that background mail synchronization never degrades the responsiveness of interactive operations. Attachments are served through a CDN, reducing load on the API server. Pagination is enforced on all list endpoints to prevent unbounded data transfer. The mobile client implements offline-aware empty states and error banners that communicate network issues to the user without crashing or silently failing.

=== Localization, Accessibility, and Platform Adaptation
The application supports Khmer and English throughout the entire interface, including dynamically rendered email metadata, error messages, and settings labels. The standard theming system ensures readability in both light and dark modes, with color tokens defined at the design-system level to prevent inconsistencies. For the Telegram Mini App variant, the specialized theme engine guarantees that platform-adaptive colors do not compromise text legibility or interactive element contrast, maintaining accessibility standards regardless of the user's Telegram theme configuration.

=== Testability and Delivery
The backend development includes a dedicated E2E and integration testing phase that verifies critical flows — authentication, mail fetching, permission resolution, and contact creation — against a real database instance. Deployment is managed through a CI pipeline with environment-specific configuration and automated database migrations. The final mobile deliverable is a *demo build* with release-optimized configuration, branded application icon, and splash screen, prepared for internal distribution within the CDC across native stores and the Telegram platform.

== System Boundaries and Integration Points

cdcIRM does not operate in isolation. It integrates with three primary external systems: the CDC's *cPanel IMAP servers* (for mail fetching and listening, consumed via a modular provider interface), *Firebase Cloud Messaging* (for cross-platform push notification delivery to mobile and web targets), and an *OCR service* (for business card scanning). Furthermore, the web-deployed variant of the application integrates deeply with the *Telegram WebApp environment*, consuming Telegram's native APIs for dynamic UI theming, haptic feedback, and viewport management.

The application does not replace the CDC's existing cPanel mail infrastructure; rather, it sits atop it as a specialized consumer, aggregating and enriching the data for a specific use case. This boundary is deliberate: it ensures that cdcIRM can be introduced incrementally — whether via native mobile or Telegram — without disrupting existing email workflows for staff who are not yet onboarded.
