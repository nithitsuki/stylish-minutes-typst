#import "@local/stylish-minutes:0.0.1": *

#show: stylish-minutes.with(
  "Event Planning Meeting",
  theme: black-white-theme, // also available: dark-mocha-theme, light-orange-theme
  date: datetime(day: 1,month: 12,year: 2025),
  location: "Microsoft Teams",
  next-date: datetime(day: 8,month: 12,year: 2025)
)

#meeting-grid(
  items: (
    // --- ROW 1 ---
    (
      "Attendees", 
      [
        - Josh Smith - Director of Marketing \
        - Stephen Waylan - Associate \
        *ABSENTEES*:
        - Jane Doe - Intern
        
      ],
    ),
    (
      "Agenda", 
      [
        *Item 1:* Seminar Title discussion \
        *Item 2:* Budget review
      ]
    ),

    // --- ROW 2 ---
    (
      "Goals and Milestones", 
      [
        1. Shortlist titles.
        2. Confirm speakers.
      ]
    ),
    (
      "Progress Tracking", 
        progress-list(
          items: (
            ("Goal 1", "In progress"),
            ("Goal 2", "In progress"),
            ("Goal 3", "Done"),
          )
      )
    ),

    // --- ROW 3 (Custom sections!) ---
    (
      "New Surprise Section", 
      [We can now add whatever we want here.]
    ),
    (
      "Next Steps", 
      [Schedule follow up for Friday.]
    ),
  )
)
