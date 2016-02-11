# StackLayout

[![Version](https://img.shields.io/cocoapods/v/StackLayout.svg?style=flat)](http://cocoapods.org/pods/StackLayout)
[![License](https://img.shields.io/cocoapods/l/StackLayout.svg?style=flat)](http://cocoapods.org/pods/StackLayout)
[![Platform](https://img.shields.io/cocoapods/p/StackLayout.svg?style=flat)](http://cocoapods.org/pods/StackLayout)

StackLayout builds on Auto Layout to make some of the most common layouts easier to manage. It creates the constraints that you need and allows you to edit them with semantic method names, like `setTopMargin:` or `setHorizontalAlignment:`. It is similar to UIStackView, but unlike UIStackView it is not a subclass of UIView. It is a layout manager you can use with any view. This has a few advantages:

- Multiple layouts in one view.
- Less wrapper views in your layout.
- Compatible with iOS 8+

## Basics

Three labels stacked vertically, hugging the top, with a space between them.

```SLVerticalStackLayout *layout = [[[[container addSubviewsWithVerticalLayout:@[headerLabel, subtitleLabel, bodyLabel]]
   setVerticalAlignment:SLAlignmentTop]
  setHorizontalAlignment:SLAlignmentFill]
 setSpacing:10];```
 
The above layout takes about 10 constraints usually, which can be a hassle to manage. The layout object manages them for you and allows you to easily change them later. You don't need to keep a reference to the layout object if you don't need it though.

## More examples


![WelcomeTipLayout](https://github.com/bridger/StackLayout/blob/master/Images/WelcomeTipLayout.png?raw=true)

```
[[[[[[[tipView addSubviewsWithVerticalLayout:@[titleLabel,
                                               bodyLabel,
                                               tipsButton,
                                               laterButton]]
      setVerticalAlignment:SLAlignmentFill]
     setHorizontalAlignment:SLAlignmentCenter]
    setHorizontalMargins:46]
   setTopMargin:34]
  setBottomMargin:17]
 setSpacing:28];

[tipView.widthAnchor constraintEqualToConstant:290];
```


## Alignment

You usually want to choose both a vertical and horizontal alignment.

- **SLAlignmentFill**
  - Use this when you want the subviews to completely fill the container (exluding space for margins). This can also make the container shrink until it is just big enough to hold the subviews. This is the most common alignment.
- **SLAlignmentTop/Bottom/Leading/Trailing**
  - Just as it sounds. The view(s) will be stuck to the margin of the container view.
- **SLAlignmentCenter**
  - This pulls the views to the middle. The layout might create invisible "helper" views to accomplish this. You can control the strength of the centering constraints using `setCenteringPriority:`.
- **SLAlignmentNone**
  - This is the default. Without an alignment the views can be layed out anywhere within the margins of the container. This is only useful when you want to align the views relative to something else in the view hierarchy.


## Spacing

All ajdacent subviews have a "space" constraint for the space between them. In the Auto Layout Visual Format Language, it looks like "[first]-space-[second]". By default, this space is set to 0 so all subviews are edge-to-edge. You can set the space between two adjacent subviews by calling `setSpacing:between:and:`. You can also adjust the spacing constraints at once by calling `setSpacing:`, which will override any other previous `setSpacing:between:and:` calls.

Spacing constraints are required by default, but can be weakened by calling `setSpacingPriority:`.
 
## Rules to Remember

If you are working with a layout where these rules are getting in the way, don't be afraid to just ditch Stack Layout and make the constraints yourself! [PureLayout](https://github.com/PureLayout/PureLayout) or NSLayoutAnchor (iOS 9+) make this easier.

#### Set both vertical and horizontal alignments

If you don't set an aligment, there are many places a subview can end up. In this layout: `[container addSubviewsWithVerticalLayout:@[ redButton, blueButton ]]`, the red and blue button stack can be in the top-left or bottom-right (or anywhere in between) of the container. This can be useful if you want views to be layed out relative to another view in the hierarchy. Generally though, you want to call both `setVerticalAligment:` and `setHorizontalAlignment:`.

#### Subviews stay within margins

Subviews usually stay entirely within the bounds of the containing view, even if there is no vertical or horizontal alignment set. This is done by the "margin" constraints. You can override this by setting the margins to a negative number or reducing the priority of the margin constraints using `setMarginsPriority:`.

#### Subviews need sizing constraints

StackLayout doesn't govern how big subviews are relative to each other. For example, this layout is ambiguous:

```
[[[container addSubviewsWithVerticalLayout:@[redView, blueView]]
  setVerticalAlignment:SLAlignmentFill]
 setHorizontalAlignment:SLAlignmentFill];
```

Together, redView and blueView fill the container but you need another constraint to say how big they are relative to each other. To make them each take up half of the container you'd need this supplemental constraint: `[redView.heightAnchor constraintEqualToAnchor:blueView.heightAnchor].active = YES;`

Often subviews already have their own size, either from `intrinsicContentSize` or from their own subviews and contraints.

## Example Project

The example project has not been built yet. If you'd like to contribute, you can build examples in the example project.

Clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

StackLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "StackLayout"
```

## Author

Bridger Maxwell, bridger.maxwell@gmail.com

## License

StackLayout is available under the MIT license. See the LICENSE file for more info.
