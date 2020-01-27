<h3 align="center">
  <a href="https://github.com/HelioMesquita/TicTacToe/blob/master/.assets/logo.png">
  <img src="https://github.com/HelioMesquita/TicTacToe/blob/master/.assets/logo.png?raw=true" alt="TicTacToe Logo" width="500">
  </a>
</h3>

[![Objective-c](https://img.shields.io/badge/Objective--c-language-blue)](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html)
[![Cocoapods](https://img.shields.io/badge/Cocoapods-compatible-orange)](https://cocoapods.org)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](https://github.com/HelioMesquita/TicTacToe/blob/master/LICENSE)

This library inserts on your application a baseline grid.

## Getting Started

<img src="https://github.com/HelioMesquita/TicTacToe/blob/master/.assets/exampleApp.png" align="center"
     title="Example" width="220  " height="476">

This tool adds the baseline grid over the application, thus allowing you to browse the entire app and verify that the alignment is following the requirements.

### Motivation 

After several problems in ensuring the alignment and baselines established in the project requirement. This tool was developed, together with the design/ux team, to facilitate and ensure that visual elements follow the established baselines.

### Prerequisites

This library was developed thinking about compatibility with any project version, so it was developed using objective-c. The iOS compatibility +9.0

## Installing

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. Insert in your `Podfile`:

```ruby
use_frameworks!

target "YourProject" do
  pod 'TicTacToe'
end
```

then

```
pod install
```

## How To Use

### Using only AppDelegate

On `AppDelegate.swift` 

```swift
import UIKit
#if DEBUG
import TicTacToe
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    #if DEBUG
    TicTacToePreferences.shared().show()
    #endif
    return true
  }

}
```

### AppDelegate and SceneDelegate

On `SceneDelegate.swift`

```swift
import UIKit
#if DEBUG
import TicTacToe
#endif

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    (...)

    func sceneDidBecomeActive(_ scene: UIScene) {
        #if DEBUG
        TicTacToePreferences.shared().isUsingScenePattern = true
        TicTacToePreferences.shared().show()
        #endif
    }

```

## Using the Grid

### On Simulator


### On Device

## Authors

* **Helio Mesquita** - *Initial work* - [HelioMesquita](https://github.com/HelioMesquita)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details