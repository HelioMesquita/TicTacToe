# TicTacToe

This library inserts on your application a baseline grid.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

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

Explain how to use

## Authors

* **Helio Mesquita** - *Initial work* - [HelioMesquita](https://github.com/HelioMesquita)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details