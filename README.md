# CoordinatorPatternExample
My practice of applying coordinator pattern in an iOS project

- Granularity
  - App coordinator
  - Main coordinator
  - Other child coordinator

- How to handle backward events
Implementing a BackwardConscious protocol to make a view controller to know then it is being pushed back or dismissed.

- How to pass value between coordinators
From parent to child, use initial functions<br/>
From child to parent, use closure when handling backward events.
