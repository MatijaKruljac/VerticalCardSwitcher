# VerticalCardSwitcher

`VerticalCardSwitcher` is inspired by Shazam Discover view. It is a vertical sequence of `UIView`s where first `UIView` in sequence is always completely displayed and every next `UIView` is partially displayed. Also there is `VerticalCardSwitcherDelegate` which is added for `VerticalCardSwitcher` customization. `VerticalCardSwitcher` is not implemented with `UICollectionView` and it's contained inside parent view.

[![CI Status](https://travis-ci.org/MatijaKruljac/VerticalCardSwitcher.svg?branch=master)](https://travis-ci.org/MatijaKruljac/VerticalCardSwitcher.svg?branch=master)
[![Version](https://img.shields.io/cocoapods/v/VerticalCardSwitcher.svg?style=flat)](http://cocoapods.org/pods/VerticalCardSwitcher)
[![License](https://img.shields.io/cocoapods/l/VerticalCardSwitcher.svg?style=flat)](http://cocoapods.org/pods/VerticalCardSwitcher)
[![Platform](https://img.shields.io/cocoapods/p/VerticalCardSwitcher.svg?style=flat)](http://cocoapods.org/pods/VerticalCardSwitcher)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first. There are two examples `FirstViewController` and `SecondViewController`.

- Example 1 (`FirstViewController`):
</br>
<p>
<p align="center">
<img src="https://github.com/MatijaKruljac/VerticalCardSwitcher/blob/master/vertical_card_switcher_example_1.gif?raw=true" >
</p>
</br>
</br>

- Example 2 (`SecondViewController`):
</br>
<p>
<p align="center">
<img src="https://github.com/MatijaKruljac/VerticalCardSwitcher/blob/master/vertical_card_switcher_example_2.gif?raw=true" >
</p>
</br>

## Requirements

- iOS 8.0+
- Xcode 8
- Swift 3.0

## Installation

VerticalCardSwitcher is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following lines to your Podfile:

```swift
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
    pod "VerticalCardSwitcher"
end
```
## Usage

1. Add `VerticalCardSwitcherDelegate` for delegate class:
```swift 
class ViewController: UIViewController, VerticalCardSwitcherDelegate {

}
```

2. Initialize and setup `VerticalCardSwitcher`:
```swift
private var verticalCardSwitcher: VerticalCardSwitcher!

verticalCardSwitcher = VerticalCardSwitcher.init(in: view)
verticalCardSwitcher.delegate = self
verticalCardSwitcher.display()
```

3. Implement `VerticalCardSwitcherDelegate` required methods:
```swift
func numberOfCards(for verticalCardSwitcher: VerticalCardSwitcher) -> Int {
    return 22
}

func distanceBetweenCards(for verticalCardSwitcher: VerticalCardSwitcher) -> CGFloat {
    return 20.0
}

func heightForCardView(in verticalCardSwitcher: VerticalCardSwitcher) -> CGFloat {
    return 430.0
}

func sideMargins(for verticalCardSwitcher: VerticalCardSwitcher) -> CGFloat {
    return 40.0
}

func addDesign(for cardView: CardView, at index: Int, in verticalCardSwitcher: VerticalCardSwitcher) {

}

// values from 0 to 1 (represents percentage of CardView height)
func heightOfShowedPartForEveryNextCard(in verticalCardSwitcher: VerticalCardSwitcher) -> CGFloat {
    return 0.20
}
```

4. Implement `VerticalCardSwitcherDelegate` optional methods for scrolling events of CardView:
```swift
func currentCardScrolledDown(cardView: CardView, for verticalCardSwitcher: VerticalCardSwitcher) {
    print("currentCardScrolledDown")
}

func nextCardScrolledUp(cardView: CardView, for verticalCardSwitcher: VerticalCardSwitcher) {
    print("nextCardScrolledUp")
}
```

## Author

Matija Kruljac, kruljac.matija@gmail.com

## License

VerticalCardSwitcher is available under the MIT license. See the LICENSE file for more info.
