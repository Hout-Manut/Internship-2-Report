= PRESENTATION OF THE INTERNSHIP
*cdcIRM* is a specialized communication platform designed to act as a bridge between the Council for the Development of Cambodia and global investors. While traditional email clients are built for general-purpose correspondence, this project is engineered for High-Velocity Investor Relations.

The application focuses on three core pillars:
- *Immediacy:* Reducing the time spent on data entry and navigation.
- *Intelligence:* Assisting staff in maintaining relationships through automated reminders.
- *Integration:* Connecting directly with CDC's backend infrastructure while maintaining government-grade security protocols.

== System Requirements
=== Functional Requirements

- *Email Synchronization:* Real-time fetching and sending of emails via RESTful APIs.
- *OCR Contact Scanner:* Utilizing the mobile camera to scan Business Cards or IDs and extract text (Name, Email, Company).
- *AI-Powered Follow-up:* Utilizing AI to enables automated reply suggestions and reminders.
// - *Global Search:* Searching through investor databases and email history simultaneously.

=== Non-Functional Requirements

- *Performance:* ...
- *Usability:* Minimalist UI/UX to reduce cognitive load.
- *Security:* Token-based authentication (JWT) to ensure only authorized CDC staff can access investor data.

== System Architecture

The project follows a Decoupled Architecture to ensure maintainability and scalability.


== Project Timeline

#figure(
  align(center)[
    #set text(size: 10pt)

    #let task-row(..weeks) = (
      ..weeks
        .pos()
        .map(w => {
          if w == [x] {
            table.cell(fill: rgb("#fede6a"))[]
          } else {
            []
          }
        }),
    )

    #table(
      columns: (30%, ..(4.375%,) * 16),
      table.header(
        table.cell(align: center, rowspan: 2)[#strong[Tasks]],
        table.cell(align: center, colspan: 16)[#strong[Weeks]],
        ..range(1, 17).map(i => table.cell(align: center)[#strong[#i]]),
      ),

      // Tasks
      table.cell(align: left)[Requirement Analysis],
      ..task-row([x], [x], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ]),

      table.cell(align: left)[Setup Project],
      ..task-row([ ], [ ], [x], [x], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ]),

      table.cell(align: left)[Development Phase],
      ..task-row([ ], [ ], [ ], [ ], [x], [x], [x], [x], [x], [x], [x], [x], [x], [x], [x], [x]),

      table.cell(align: left)[Testing],
      ..task-row([ ], [ ], [ ], [ ], [ ], [ ], [x], [x], [x], [x], [x], [x], [x], [x], [x], [x]),

      table.cell(align: left)[Bug Fixes and UAT],
      ..task-row([ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [ ], [x], [x], [x], [x], [x]),

      table.cell(align: left)[Documentation],
      ..task-row([x], [x], [x], [x], [x], [x], [x], [x], [x], [x], [x], [x], [x], [x], [x], [x]),
    )
  ],
  caption: "Activities Timeline",
) <activity_table>


#include "../components/timeline.typ"

(DRAFT) @activity_table Outlines the timeline for the entire Internship 2 project span.
For the first month, I spent most of the time initializing the project—including the file structure, dependencies and others.
