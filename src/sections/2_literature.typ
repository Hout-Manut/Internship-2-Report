= Literature Review

== Existing Systems Analysis
The landscape of email communication has shifted from simple message exchange to complex productivity ecosystems. While traditional clients focus on stability and broad feature sets, modern "power-user" clients prioritize speed and organizational efficiency. This section establishes a benchmark for the cdcIRM application by analyzing leading global solutions.

=== Enterprise Industry Standards: Gmail & Outlook
- *Gmail:* Recognized for its powerful search capabilities and deep integration with Google Workspace. It pioneered features like "Smart Compose" and tabbed categorization. However, for high-stakes investor relations, users often find its interface "cluttered" and prone to distractions from non-essential automated mail. #cite(<google_gmail>)
- *Microsoft Outlook:* The definitive standard for "locked-down" institutional organizations. Its strength lies in robust calendar integration and enterprise-grade security (S/MIME). For the CDC, Outlook is often a primary backend provider; however, its mobile interface is frequently criticized for being heavy and unintuitive for rapid, on-the-go tasks such as contact scanning. #cite(<microsoft_outlook>)

=== High-Productivity & AI-Driven Clients: Superhuman & Spark
- *Superhuman:* Widely considered the fastest email experience currently available. It utilizes a "keyboard-first" philosophy and a "Split Inbox" to separate human-sent emails from automated notifications. A key relevant feature is *AI-powered follow-ups,* which nudge users to maintain momentum in communication—a critical need for investor relations.
- *Spark Mail:* Developed by Readdle, Spark emphasizes team collaboration and "Smart Categorization." Its standout feature allows users to screen new senders, a valuable concept for government officials who must filter high volumes of unsolicited inquiries.

=== Specialized CRM & Contact Integration
Platforms such as *Salesforce Anywhere* and *HubSpot Mobile* facilitate lead management by allowing users to scan business cards to create CRM entries. While these provided the inspiration for the cdcIRM contact scanning module, they are proprietary, high-cost platforms that do not natively integrate with the specific ID formats or the private server infrastructure required by the Cambodian government.

== Engineering Theory and Design Patterns
To bridge the gaps identified in existing systems, this project utilizes several computer science patterns to ensure scalability, security, and bilingual support.

=== The Adapter Pattern for Service Abstraction
A primary challenge in email aggregation is "Interface Incompatibility" between disparate providers (e.g., Gmail's REST API vs. private IMAP servers). Academic literature identifies the *Adapter Design Pattern* as a structural solution that allows incompatible interfaces to collaborate. By implementing a unified `MailAdapter` interface in NestJS, the core application remains decoupled from provider-specific logic, allowing for the seamless addition of new email services without core code modification.

=== Zero Trust and Context-Aware Security
Traditional security models often rely on a "Binary Perimeter" (authenticated vs. unauthenticated). Modern enterprise security has shifted toward *Zero Trust Architecture (ZTA)*, which posits that trust must be continuously verified. The cdcIRM "Trust Engine" applies these principles by calculating a *Trust Score* based on environmental metadata (IP Geolocation, Device Fingerprinting, and login history), ensuring that sensitive actions are only permitted when a session meets a specific trust threshold.

=== Relational Localization and Data Sovereignty
Localizing applications for government contexts (Khmer/English) requires a strategy for *Dynamic Data Sovereignty*. While static UI labels can be bundled with the client, dynamic data (such as investor categories) requires a relational approach. This project have been made from the ground up with localizing in mind.

=== High-Concurrency Data Streaming
Handling large volumes of investor correspondence requires efficient data transfer strategies:
- *WebSockets:* To replace expensive HTTP polling, WebSockets provide bi-directional, real-time updates for new emails.
- *Cursor-based Pagination:* Unlike "Offset" pagination, which can skip or duplicate records when new data is inserted, cursor-based pagination ensures a stable, high-performance "infinite scroll" experience, which is essential for managing extensive email threads.
