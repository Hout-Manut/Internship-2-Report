= PROJECT ANALYSIS AND CONCEPTS

This chapter presents the analysis and design concepts of the *cdcIRM* mobile application.
It defines the problem scope, functional and non-functional requirements, core use cases,
system data design, and workflow diagrams used to guide implementation.

The objective of this chapter is to translate internship project goals into a clear technical
plan that can be implemented, tested, and maintained within the CDC working environment.

== Problem Analysis

The Council for the Development of Cambodia, especially within the Information Technology
and Public Relation Directorate, handles frequent communication with investors, partners,
and stakeholders. In practice, communication workflows are often slowed down by three main issues:

- *Fragmented communication flow:* Staff use standard email tools that are not optimized for investor relation workflows.
- *Manual contact entry:* Business cards and contact details are often entered manually, which is time-consuming and error-prone.
- *Follow-up inconsistency:* Important investor conversations may require reminders and follow-up actions, but these are often tracked manually.

To address these challenges, the *cdcIRM* project was designed as a mobile-first investor communication
tool that combines email, contact extraction, and follow-up assistance into one application.

== System Scope and Concept

The proposed system is a specialized mobile client for internal CDC staff use. It is not intended to replace
existing enterprise email infrastructure. Instead, it acts as a productivity layer on top of CDC backend services.

The application provides:
- Secure authentication for authorized CDC staff
- Email inbox and message management
- OCR-based contact extraction from business cards or IDs
- Follow-up reminders and AI-assisted drafting support
- Contact-centered investor communication tracking

The system concept emphasizes:
- *Speed:* fewer steps to process emails and contacts
- *Clarity:* a focused interface for official communication
- *Security:* controlled access using token-based authentication
- *Extensibility:* modular architecture for future features

#pagebreak()

== Functional Requirements

Functional requirements define what the system must do from the user perspective.

// @typstyle off
#figure(
  table(
    columns: (1fr, 4fr, 8fr),
    inset: 4pt,
    table.header([*ID*], [*Feature*], [*Description*]),

    [1],
    [User Authentication],
    align(left)[The system shall allow CDC staff to log in securely using credentials provided by the organization backend.],

    [2],
    [Profile Retrieval],
    align(left)[The system shall retrieve and display the authenticated user profile (name, role, language preference, and contact information).],

    [3],
    [Inbox Listing],
    align(left)[The system shall display a list of email messages with essential metadata such as sender, subject, timestamp, and status (read/unread).],

    [4],
    [Email Detail View],
    align(left)[The system shall display full email content and attachments metadata when a message is selected.],

    [5],
    [Compose and Send Email],
    align(left)[The system shall allow users to compose, reply to, and forward messages through the integrated CDC backend APIs.],

    [6],
    [Search Email],
    align(left)[The system shall allow users to search email messages by sender, subject, or keywords.],

    [7],
    [Investor Contact Scanning],
    align(left)[The system shall capture an image from the device camera and extract contact data such as name, company, phone number, and email address.],

    [8],
    [Investor Contact Review and Edit],
    align(left)[The system shall allow users to review and correct OCR results before saving them.],

    [9],
    [Investor Contact Storage],
    align(left)[The system shall save validated contact information into the system for future communication use.],

    [10],
    [Follow-up Reminder],
    align(left)[The system shall allow users to create and manage follow-up reminders related to investor contacts or email threads.],

    [11],
    [AI Assistance],
    align(left)[The system shall support AI-based drafting or response suggestions for selected email messages.],

    [12],
    [Notification Handling],
    align(left)[The system shall notify users about pending follow-ups, important messages, or system events.],

    [14],
    [Language Preference],
    align(left)[The system shall support application localization and allow switching between Khmer and English.],
  ),
  caption: "Functional Requirements of the cdcIRM System",
) <fr_table>
// @typstyle on


@fr_table summarizes the core features required for the initial internship implementation. The selected
requirements focus on practicality and direct value for CDC staff workflows.

== Non-Functional Requirements

Non-functional requirements define how the system should behave in terms of quality, security, and maintainability.

// @typstyle off
#figure(
  table(
    columns: (18%, 82%),
    table.header([*Category*], [*Requirement*]),

    [Performance],
    align(left)[The application should load the inbox screen within a few seconds under normal network conditions and avoid unnecessary UI blocking during API requests.],

    [Usability],
    align(left)[The user interface should be simple, readable, and optimized for mobile use by non-technical and technical staff alike. Important actions should be reachable with minimal taps.],

    [Security],
    align(left)[The system should use token-based authentication (JWT), secure API communication over HTTPS, and protected local storage for sensitive session data.],

    [Reliability],
    align(left)[The system should handle network failures gracefully by providing clear feedback and retry options without crashing.],

    [Maintainability],
    align(left)[The codebase should follow a modular architecture with clear separation between data models, services, state management, and UI components.],

    [Scalability],
    align(left)[The design should support future additions such as calendar integration, investor tagging, analytics, and advanced AI modules.],

    [Compatibility],
    align(left)[The mobile application should run on modern Android and iOS devices used by CDC staff.],

    [Localization],
    align(left)[The system should support Khmer and English text resources and be designed to allow adding more languages in the future.],
  ),
  caption: "Non-Functional Requirements",
) <nfr_table>
// @typstyle on

#pagebreak()

== Use Case Analysis

Use case analysis explains how different users interact with the system to achieve their tasks.

=== Primary Actor
The primary actor of the system is:

- *CDC Staff User:* Authorized officer using the mobile application for investor communication and follow-up management.

=== Supporting Actors / External Systems
- *CDC Backend API:* Provides authentication, user profile, email synchronization, and contact-related services.
- *OCR Engine:* Extracts text from captured business card or ID images.
- *Notification Service:* Delivers local or push notifications for reminders and updates.
- *AI Service:* Generates drafting suggestions and follow-up assistance.

=== Main Use Cases

// @typstyle off
#figure(
  table(
    columns: (25%, 75%),
    table.header([*Use Case*], [*Description*]),

    [Login],
    align(left)[User authenticates with CDC credentials and obtains a secure session token.],

    [View Inbox],
    align(left)[User opens the inbox and reviews incoming messages from investors or partners.],

    [Read Email],
    align(left)[User opens a message to read full content and take an action (reply, forward, archive, etc.).],

    [Compose Email],
    align(left)[User creates a new message or replies to an existing email thread.],

    [Scan Contact],
    align(left)[User scans a business card or ID using the camera to capture contact details automatically.],

    [Save Contact],
    align(left)[User verifies OCR result and saves the contact into the system.],

    [Create Follow-up],
    align(left)[User creates a reminder linked to a contact or conversation for future action.],

    [Receive Reminder],
    align(left)[System notifies user when a scheduled follow-up is due.],

    [AI Draft Suggestion],
    align(left)[User requests an AI-generated draft or response suggestion for an email.],
  ),
  caption: "Main Use Cases",
) <use_case_table>
// @typstyle on

=== Use Case Diagram (Conceptual)

The formal use case diagram can be inserted as a figure in the final report. For documentation clarity,
the actor-to-use-case relationships are listed below.

- *CDC Staff User* `->` Login, View Inbox, Read Email, Compose Email
- *CDC Staff User* `->` Scan Contact, Save Contact, Create Follow-up, Receive Reminder
- *CDC Staff User* `->` AI Draft Suggestion (optional)
- *CDC Backend API* `<->` Authentication, Email Sync, Contact Storage
- *OCR Engine* `<->` Scan Contact
- *Notification Service* `<->` Receive Reminder
- *AI Service* `<->` AI Draft Suggestion

// TODO
#figure(
  align(center)[
    #box(
      inset: 10pt,
      radius: 6pt,
      stroke: luma(180),
      fill: luma(248),
      width: 100%,
      [
        *Use Case Diagram Placeholder*

      ],
    )
  ],
  caption: "Use Case Diagram of cdcIRM (Conceptual Placeholder)",
) <use_case_diagram>

== Process Flow and Activity Concepts

This section describes the main activity flow of the application from login to communication and follow-up.

=== Core Workflow (Narrative)

1. The user opens the application and signs in using CDC credentials.
2. The system validates credentials through the backend and stores a secure session token.
3. The inbox is loaded and synchronized with the backend email service.
4. The user may read emails, compose new messages, or scan a contact card.
5. If scanning is used, OCR extracts text and returns candidate contact fields.
6. The user reviews and edits extracted data before saving.
7. The user can create a follow-up reminder for an investor conversation.
8. The system schedules a reminder and notifies the user at the specified time.

=== Activity Diagram (Conceptual)

// TODO
#figure(
  align(center)[
    #box(
      inset: 10pt,
      radius: 6pt,
      stroke: luma(180),
      fill: luma(248),
      width: 100%,
      [
        *Activity Diagram Placeholder*

      ],
    )
  ],
  caption: "Activity Diagram for Main User Workflow (Placeholder)",
) <activity_diagram>

== Data and Database Design

Although the internship project focuses on mobile application development, a clear data model is required
to ensure smooth integration with backend APIs and future expansion. The database design presented here
represents the conceptual structure of the main entities used by the system.

=== Main Entities

The system revolves around the following core entities:

- *User:* CDC staff account and profile information
- *Message:* Email metadata and content
- *Contact:* Investor or stakeholder contact details
- *Attachment (optional):* File metadata associated with emails
- *Audit Fields:* Created/updated timestamps for traceability

=== Conceptual Entity Relationships

- One *User* can manage many *Contacts*
- One *User* can create many *Follow-up Reminders*
- One *Contact* can be linked to many *Email Messages*
- One *Email Message* can contain multiple *Attachments*
- One *Follow-up Reminder* may reference a *Contact* and/or an *Email Message*

// TODO
#figure(
  align(center)[
    #box(
      inset: 10pt,
      radius: 6pt,
      stroke: luma(180),
      fill: luma(248),
      width: 100%,
      [
        *Database Table Relations Placeholder*

      ],
    )
  ],
  caption: "Database Table (Placeholder)",
) <database_table_diagram>

=== Database Design Considerations

The following design principles are important for this project:

- *Normalization:* Separate contacts, emails, and reminders to avoid duplicate data.
- *Traceability:* Include timestamps for creation and updates.
- *Extensibility:* Keep optional fields flexible for future modules (e.g., investor tags, categories, priority).
- *Security:* Avoid storing sensitive tokens or secrets directly in business tables.
- *Integration-first:* The mobile app may not directly access the database, but entity design should align with backend API responses.

=== Sample Data Dictionary (Selected Fields)

#figure(
  table(
    columns: (22%, 18%, 20%, 40%),
    table.header([*Table*], [*Field*], [*Type*], [*Description*]),

    [users], [id], [UUID / String], [Unique identifier of CDC staff user.],
    [users], [language], [String], [Preferred app language (e.g., "en", "km").],

    [contacts], [source], [String], [Indicates how the contact was created: manual or OCR scan.],
    [contacts], [email], [String], [Primary investor contact email address.],

    [messages], [thread_id], [String], [Groups related messages into one conversation thread.],
    [messages], [is_read], [Boolean], [Read/unread state for UI display.],
  ),
  caption: "Selected Data Dictionary",
) <data_dictionary>

== Analysis of Technical Architecture

To support maintainability and future growth, the mobile application adopts a layered architecture.

=== Proposed Application Layers

- *Presentation Layer:* Flutter UI screens, widgets, and user interactions
- *State Management Layer:* Handles screen state, loading state, and user actions
- *Domain/Logic Layer:* Business rules such as validation, reminder logic, and workflow handling
- *Data Layer:* API clients, local storage, serialization, and repository implementations
- *External Services Layer:* OCR, AI assistance, notification service, and backend APIs

This separation improves:
- Code readability
- Testing capability
- Feature scalability
- Team collaboration during future maintenance

=== API and Data Exchange Considerations

The backend communication is expected to use JSON-based REST APIs. During analysis, the following
integration concerns were considered:

- Authentication token refresh and secure storage
- Standardized API response format (success/error)
- Consistent date-time parsing (ISO 8601)
- Pagination for inbox and contact lists
- Snake_case API keys mapped to camelCase mobile models
- Error handling for unstable network conditions

These considerations influenced the model and service design in the implementation phase.
