# DJTabBarController
- A view controller with a scrollable tabBar that has uncertain number of items. Each item shows a specific view.

- Objective-C: You can click [Here](https://github.com/iwufan/DWScrollTabBarController) to get the Objective-C version of this framework.

# Why shoud I use this framework
- You can build a view controller with scrollable tabBar in only a few steps.<br>
- The items in the tabBar can be dynamic. The items in the tabBar can be different every time you open the view controller. <br>
- You don't have to create a class file for each item. What you should do is to create a view for each item.<br>

- You can use this framework to create view controllers like these below.

- It can be used on iPhoneX now.

![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example1.gif)
![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example2.gif)
![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example3.gif)
![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example4.gif)
![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example5.gif)
![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example6.gif)

# Installation

- ### Manual import<br>

Drag all the files in the `DJTabBarController` folder to your project.

# How to use it
- ### Extends DJTabBarController <br>
```
class DJViewController: DJTabBarController 
```
NOTE: You can make `DJTabBarController` extends your base ViewController in your project if necessary, instead of extending `UIViewController`.

- ### Setup customized properties in `viewDidLoad` method
```
// color
normalTitleColor            = UIColor.black
currentTitleColor           = UIColor.white
normalButtonBgColor         = UIColor.blue
currentButtonBgColor        = UIColor.orange
tabBarBgColor               = UIColor.white
// font
normalTitleFont             = UIFont.systemFont(ofSize: 13)
currentTitleFont            = UIFont.systemFont(ofSize: 18)
// height
tabBarHeight                = 30;
// button width
isUnifiedWidth              = false;
// indicator line
isShowIndicatorLine         = false;
indicatorLineHeight         = 2;
indicatorLineColor          = UIColor.red
indicatorLineWidth          = 50;
isIndicatorLineInCenter     = true;
// bottom line
isShowBottomLine            = true;
bottomLineHeight            = 1;
bottomLineColor             = UIColor.black
// margin
isShowViewMargin            = true;
viewMargin                  = 10;
leftMargin                  = 10;
rightMargin                 = 0;
buttonMargin                = 10;
// others
isBounces                   = true;
isScrollable                = true;
```
#### Tip: You DO NOT have to setup all these properties. Every property has a default value.
`isUnifiedWidth` is a special property. It's default value is 'false', so if you do not set it as 'true', the tabBar item's width is calculated based on the item's title. The more words on the title, the wider the title.<br>
If you set `isUnifiedWidth` as 'true', every item's width will be the same. You should set `buttonWidth` as you want, it has a default value 100. 
#### Note: If you show `indicatorLine` and `bottomLine` at the same time. The indicator line may be covered by bottom line.
- ### Setup data in `viewDidLoad` method
```
/**
!!!!! NOTE:
You MUST set properties of tab bar before set value for 'tabItemArray', otherwise the properties
you set for tab bar will not take effect.
You can hardcode the types in the code or get the types data from server. It doesn't matter how
many types are.
*/
tabItemArray = ["Military", "Games", "Societies", "Sports", "Entertainment", "Headline", "Women", "Politics", "Fashion"]

// Add all tableviews that need to display data
tableViewArray = setupSubviews()
```
#### Tip: You MUST setup data AFTER setting properties. Or you will get nothing in the tabBar.
The `setupSubViews` method should be implemented by yourself. Please refer to below for details.
- ### LoadDefaultData in `viewDidLoad` method
```
loadTableViewData()
```
Load first type's data by default.
This method should be implemented by yourself. Please refer to demo for details.
- ### Create your own tableView to display data.
This tableView should have a property `typeID`, and load data in its setter method.
```
var typeID: String! {
    didSet {
        loadData()
    }
}
```
Then you can load data based on different types.

Add them to the property `tableViewArray`
```
/// Add all tableviews that need to display data
private func setupSubviews() -> [DJTableView] {

    var typeTableViews = [DJTableView]()

    tabItemArray.forEach { (_) in
        let tableView = DJTableView()
        typeTableViews.append(tableView)
    }

    return typeTableViews
}
```
```
// Add all tableviews that need to display data
tableViewArray = setupSubviews()
```
You can refer to the demo project for the example tableView.

- ### Implement `DJTabBarController` delegate methods. 
Please refer to demo for details. You can use the codes of the two methods in the demo directly.
```
override func didClickTabButton(tabBar: DJScrollTabBar, tabButton: UIButton) -> Bool {
    // if the click is caused by scroll the tableviews, then don't need to load data
    let isScrolled = super.didClickTabButton(tabBar: tabBar, tabButton: tabButton)

    if !isScrolled {
        // load data for a specific type
        loadTableViewData()
    }

    return false
}
override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

    super.scrollViewDidEndDecelerating(scrollView)
    // load data for a specific type
    loadTableViewData()
}
private func loadTableViewData() {

    guard let tableViewArray = tableViewArray else {
        return
    }

    let view: DJTableView = tableViewArray[currentPage] as! DJTableView
    view.typeID = "\(currentPage ?? 0)"
}
```
#### Tip: You ONLY can use these two methods above to load every page's data. Please add your 'loadData' method to these two methods.
- Above is all you shoud do with this framework. More you shoud do are add customized views to this framework and load data from your server. <br>
#### Plese refer to demo for details.

