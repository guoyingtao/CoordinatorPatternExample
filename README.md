# CoordinatorPatternExample
My practice of applying coordinator pattern in an iOS project

- Granularity
  - App coordinator
  - Main coordinator
  - Other child coordinators
  
  Usually, nagivation includes 
  1. using navigation controller to push a view controller to its child view controllers stack
  2. preseting another view controller
  
  So bedisde Coordinator protocol, I make PresentingCoordinator and NavigationCoordinator too. They both conform to Coordinator protocol but have their own navigation functions.
  
  Also, to make things more easier, I made three base classes
  1. class BasePresentingCoordinator: PresentingCoordinator
  2. class BaseNavigationCoordinator: NavigationCoordinator
  3. class BaseVersatileCoordinator: VersatileCoordinator (VersatileCoordinator:PresentingCoordinator,  NavigationCoordinator)
  
  For a child coordinator, if the view controller it manages is being pushed by a navigation controller, choose NavigationCoordinator as its parent class and use navigate(:::) to show the view controller.</br>
  if the view controller it manages is being presented, choose PresentingCoordinator as its parent class and use present(:::) to show the view controller.</br>
  If the view controller can be pushed and presented, then use BaseVersatileCoordinator as its parent class.
  

- How to handle backward events
Implementing a BackwardConscious protocol to make a view controller to know then it is being pushed back or dismissed.

- How to pass value between coordinators
From parent to child, use initial functions<br/>
From child to parent, use closure when handling backward events.
