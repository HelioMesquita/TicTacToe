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
<p>
<img src="https://github.com/HelioMesquita/TicTacToe/blob/master/.assets/exampleApp.png" align="right"
     title="Example" width="220  " height="476">
<sub><i>Example of usage on <a href="https://github.com/HelioMesquita/Swiftmazgin/" title="A iOS application with layout based on App Store that can check the most starred and last updated Swift repository">Swiftmazing</a> app</i></sub>
</p>

This tool adds the baseline grid over the application, thus allowing you to browse the entire app and verify that the alignment is following the requirements. There are two options of baseline - 4 and 8 size

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

It is possible to observe that there are two areas highlighted in the Debug View Hierachy mode, when these areas are called at the same time they trigger the action to activate or change the way that the baseline is appearing on the screen.

### On Simulator

Hold down the Option key, which makes two circles appear that, just tap that area :)

<p align="center">
    <img src="https://github.com/HelioMesquita/TicTacToe/blob/master/.assets/debugMode.png" height="500" max-width="40%" alt="Debug mode" />
    <img src="https://github.com/HelioMesquita/TicTacToe/blob/master/.assets/twoTaps.png" height="500" max-width="40%" alt="Two taps" />
</p>

## Authors

* **Helio Mesquita** - *Initial work* - [HelioMesquita](https://github.com/HelioMesquita)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details