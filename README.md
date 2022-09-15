# SatoshiWallet - App Challenge

## Executing the App
- Execute `pod install`
- Open `SatoshiWallet.xcworkspace` 
- Run the `SatoshiWallet` scheme 

## Testing the App
- Execute `pod install`
- Open `SatoshiWallet.xcworkspace` 
- Run the `CI` scheme in iPhone 13 Pro;

- - - 

## Explaining some key points

### About architecture
Since it's a small challenge, there's made a decision of no needed decoupled repos to main create external Pods neither SPMs.
The structure followed was to do the less complexity as possible and less decouple as possible as well.

Was used MVVM as Visual Architecture Pattern to decouple resposabilities and improve testability, using ServicesProtocols to abstract the real network layer, and improve testability of each class, using any Stub that was needed in Tests Target, handling native closures when internal classes should interact with external ones, such as ViewModel and ViewControllers.

Was created an additional context to exemplify interaction between Scenes and making an usage of Coordinator Pattern to reduce navigation responsability of each scene.

### Pods
The usage of some pods was only to improve coding speed, taking care of some points.

Explaining with few words usage decision of each Pod:

- Moya: Just to quick usage of network module, doing the requests.
- Kingfisher: Just to quick tasks and memory management when doing async fetch of URL into Views.
- Lottie: Just to make the application more fun to develop :).
- SwiftLint: Just to make sure that I'll not make my code a cake when I'm doing this challenge at 3 a.m.
- SnapshotTesting: To create Snapshot tests of UI.

## How does the app look?
![List dark mode](/Images/AppImages/IMG_3015.png)

- - - 

# What was provided?
## App main description: 
    - You will use the Bitfinex API (https://docs.bitfinex.com/reference#rest-public-tickers) to retrieve the data. 
    - The screen should show a list of trading pairs with their current price. As an inspiration we are attaching a screenshot to the PDF Challenge.
   
## App requirements:
    - Data on screen should update automatically every 5 seconds.
    - Users should be able to filter the results using a search bar.
    - The app should be resilient to network issues. Users should be able to tell when the data is not updating or it cannot be fetched.
    - Unit tests for business logic.
    - Use technologies/patterns/libraries that you are most comfortable with.
    - Project should be available on a public git repository. We should be able to clone it and run it.
    - You can use this as a list of pairs or choose your own - ?symbols=tBTCUSD,tETHUSD,tCHSB:USD,tLTCUSD,tXRPUSD,tDSHUSD, tRRTUSD,tEOSUSD,tSANUSD,tDATUSD,tSNTUSD,tDOGE:USD,tLUNA:USD,tMATIC:USD,tNEXO:USD,tOCEAN:USD,tBEST:USD, tAAVE:USD,tPLUUSD,tFILUSD

- - - 

# What's the minimum viable product of challenge?
 - iOS Application written in Swift, using UIKit framework, and running;
 - Basic layout (at least need show all data, and be responsible in iPhones);

### What can be done into MVP:
  - iOS Application using UIKit and InterfaceBuilders responsible with componentization;
  - Clean layout following suggestion;
  - MVVM Pattern;
  - Unit tests;
  - Integration tests;
  - Usage of Light/Dark mode into iOS application;
  
### What can be done v.2 after MVP delivery:
  - Implementation of Design System into app;
  - Component Snapshot Tests;
  - Layout improvement, created using some UI/UX concepts;
  - CI Implementation + AppDistribution Delivery;
  
### What can be done v.3:
  - Refactoring to ViewCode;
  - Native Network Layer;
  - Unit tests of Full Network Layer;
  
### What can be done v.4:
  - Localization Module, turning app multilanguage;
  - Accessibility Implementation and Responsilities;
  - Turn into a modular architecture using SPM;

### What can be done v.5:
  - iOS Application using SwiftUI
  - WatchOS application using SwiftUI;
  - Widget using SwiftUI;
  - Full CRUD Swift Backend coded using Fluent and Vapor, and deployed to Heroku;

- - - 

# Challenge Roadmap for MVP:
  - Create project;
  - Configure base project;
  - Create main access point;
  - Create List Scene;
  - Integrate List Scene with provided API;
  - Search Feature into List Scene;
  - Create Detail Scene;
  - Do the entire base code;
  - Make code-review;
  - Run all tests, after clean, build an reinstall the app;
  - Update Readme;
  - Share for Review.
