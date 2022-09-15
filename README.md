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

## Description of app behaviors
This is a simple app that you can see a list of cryptos.

The applcation is getting top 200 cryptos of marketcap information `(such as image, name, ranking, supply, max supply and explorer value)` based on CoinCapApi Assets `(https://docs.coincap.io/)`, then getting the price with pair USD and daily relative variation of those that Bitfinex API Tickers `https://docs.bitfinex.com/reference/rest-public-tickers` returns.

Obs: Not showing all top 200 because Bitfinex API don't send some values with ticker SYMBOLUSD or SYMBOL:USD.

You can see more information about each crypto listed clicking on the table, and search for some crypto by the name or symbol.

#### Fetch data

- The first time that the apple is handled, it will get assets and tickers of bitfinex api to map the values into a complete Crypto information;
- If it fails `(ex: network error)` user will see a full screen error.
- If it succeed, a list of cryptos will be shown and the values will be updated each 5 seconds, showing a visual feedback to user when it occours.
- If the update fails `(ex: network error)` user will see a visual information showing that the list is not updated and the values could be wrong.

#### Search for Crypto

- You can search for crypto that comes in list by ticker or name.
- If the API returns Bitcoin, Bitcoin SV, Bitcoin Gold and Dogecoin:
- Searching for BI, you will be shown Bitcoin, Bitcoin SV, Bitcoin;
- Searching for coin, you will see all of them;
- Searching for SV, you will see only Bitcoin SV;

#### Light and Dark mode

- The app handle light and dark mode, based on design system adaptative colors used, dark mode is my favorite, you should try! ;) 

- - - 

## How does the app look?

![ImageScreens](https://user-images.githubusercontent.com/28540263/190286052-ed6e6706-4209-409a-9faa-6edce2d22bbc.png)

- - - 

## Explaining some development key points

### About architecture
Since it's a small challenge, there's made a decision of no needed decoupled repos to main create external Pods neither SPMs.
The structure followed was to do the less complexity as possible and less decouple as possible as well.

Was used MVVM as Visual Architecture Pattern to decouple resposabilities and improve testability, using ServicesProtocols to abstract the real network layer, and improve testability of each class, using any Stub that was needed in Tests Target, handling native closures when internal classes should interact with external ones, such as ViewModel and ViewControllers.

Was created an additional context to exemplify interaction between Scenes and making an usage of Coordinator Pattern to reduce navigation responsability of each scene.

Some decision made just for fun, was fetch an crypto asset list of `https://docs.coincap.io/`, then get the symbols and try to fetch the Bitfinex API with them. Some error was that the tickers don't respect the SYMBOLUSD as query param, so I've cached some values to force show.

Position, Names, Assets and Symbol are informations of CoinCapAPI, prices and variations are informations of Bitfinex API.
Details Scene informations such as Supply or explorer value are from CoinCapAPI as well.

### Pods
The usage of some pods was only to improve coding speed, taking care of some points.

Explaining with few words usage decision of each Pod:

- Moya: Just to quick usage of network module, doing the requests.
- Kingfisher: Just to quick tasks and memory management when doing async fetch of URL into Views.
- Lottie: Just to make the application more fun to develop :).
- SwiftLint: Just to make sure that I'll not make my code a cake when I'm doing this challenge at 3 a.m.
- SnapshotTesting: To create Snapshot tests of UI.

- - - 

### About testing and folder organization

- It was built to be clean and easy to understand where are located, and where which file is contained. A kind of modularization by folders.

![Folder organization](https://user-images.githubusercontent.com/28540263/190357063-b252fc0b-7c5a-4a0c-9843-53314ceaf057.png)

- Was made several unit tests of the application, reaching the coverage of all important core classes up to 100%.
- Each test files and folders were mirrored to the main app, so it's easy to reach them.

![Test Coverage](https://user-images.githubusercontent.com/28540263/190356730-e8ce10d7-8cc0-470d-ab42-f263ca2533fe.png)

About Snapshot testing, was made tests in Light and Dark mode of every view to check the layout elements using stubs to inject values;

![Tests](https://user-images.githubusercontent.com/28540263/190357521-ab424397-72ac-4e72-8f8d-188e30096162.png)

OBS: I'm not sure why, the `DetailViewControllerSnapshotTests` sometimes fail, some times succeed even I've cleaned and update the images several times.

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
 - iOS Application written in Swift, using UIKit framework, and running; ✅
 - Basic layout (at least need show all data, and be responsible in iPhones); ✅

### What can be done into MVP:
  - iOS Application using UIKit and InterfaceBuilders responsible with componentization; ✅
  - Clean layout following suggestion; ✅
  - MVVM Pattern; ✅
  - Unit tests; ✅
  - Integration tests; ✅
  - Usage of Light/Dark mode into iOS application; ✅
  
### What can be done v.2 after MVP delivery:
  - Implementation of Design System into app; ✅
  - Component Snapshot Tests; ✅
  - Layout improvement, created using some UI/UX concepts; ✅
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
  - Create project; ✅
  - Configure base project; ✅
  - Create main access point; ✅
  - Create List Scene; ✅
  - Integrate List Scene with provided API; ✅
  - Search Feature into List Scene; ✅
  - Create Detail Scene; ✅
  - Do the entire base code; ✅
  - Make code-review; ✅
  - Run all tests, after clean, build an reinstall the app; ✅
  - Update Readme; ✅
  - Share for Review.
