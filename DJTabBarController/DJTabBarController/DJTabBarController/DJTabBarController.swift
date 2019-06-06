//
//  DJTabBarController.swift
//  DJTabBarController
//
//  Created by 贾大伟 on 2018/8/30.
//  Copyright © 2018 david. All rights reserved.
//

import UIKit

let dj_screenHeight = UIScreen.main.bounds.height

class DJTabBarController: UIViewController {

    /// The tab bar on the top
    var scrollTabBar: DJScrollTabBar!
    /// The main view(store all sub tableviews)
    lazy var scrollView: UIScrollView! = {
        
        let tempViewMargin: CGFloat = isShowViewMargin ? viewMargin : 0

        let height = dj_screenHeight - tabBarHeight - tempViewMargin - navHeight
        
        let scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: navHeight + tabBarHeight + tempViewMargin, width: dj_screenWidth, height: height))
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        
        view.addSubview(scrollView)
        
        return scrollView
    }()
    /// The array of all type objects, the items that displayed in the bar
    var tabItemArray: [String]! {
        didSet {
            
            addScrollTabBar()
            setupColors()
            setupButtonWidth()
            setupMargins()
            setupDefaults()
            setupLine()
            setupFonts()
            
            scrollTabBar.tabItemArray = tabItemArray
        }
    }
    /// The array of all sub tableviews
    var tableViewArray: [UIView]! {
        didSet {
            
            addTableViews()
        }
    }
    /// The index of current page
    var currentPage: Int!
    
    /// The font of buttons in normal status (default: "normal, 14")
    var normalTitleFont: UIFont! = UIFont.systemFont(ofSize: 14)
    /// The font of buttons in selected status (default: the same with 'normalFont')
    var currentTitleFont: UIFont?
    
    /// The title color of buttons in normal status (default: 'black')
    var normalTitleColor: UIColor! = UIColor.black
    /// The title color of buttons in selected status (default: 'orange')
    var currentTitleColor: UIColor! = UIColor.orange
    /// The background color of buttons in normal status (default: 'white')
    var normalButtonBgColor: UIColor! = UIColor.white
    /// The background color of buttons in selected status (default: 'white')
    var currentButtonBgColor: UIColor! = UIColor.white
    
    /// The background color of tab bar (default: 'white')
    var tabBarBgColor: UIColor! = UIColor.white
    /// The margin between tab bar and tableview (default: 10)
    var viewMargin: CGFloat! = 10
    /// Show view margin or not (default: 'false')
    var isShowViewMargin: Bool! = false
    
    /// The margin between buttons (default: 0)
    var buttonMargin: CGFloat! = 0
    /// The margin between the tab bar's left side and the first button's left side (default: 0)
    var leftMargin: CGFloat! = 0
    /// The margin between the tab bar's right side and the last button's right side (default: the same with 'leftMargin')
    var rightMargin: CGFloat! = 0
    /// The height of tab bar (default: 40, the same with buttons' height)
    var tabBarHeight: CGFloat! = 40
    /// The width of buttons. (default: 0. if 'unifiedWidth' is 'false', no need to set this property)
    var buttonWidth: CGFloat! = 0
    
    /// The color of indicator line (default: the same with 'currentTitleColor')
    var indicatorLineColor: UIColor?
    /// The width of indicator line (default: the same with button's width)
    var indicatorLineWidth: CGFloat! = 0
    /// The height of indicator line (default: 1)
    var indicatorLineHeight: CGFloat! = 1
    /// The indicator line is in the center or not (default: false)
    var isIndicatorLineInCenter: Bool! = false
    /// Show indicator line or not (default: 'false')
    var isShowIndicatorLine: Bool! = false
    
    /// The color of bottom line of tab bar (default: 'lightGray')
    var bottomLineColor: UIColor! = UIColor.lightGray
    /// The height of bottom line of tab bar (default: 1)
    var bottomLineHeight: CGFloat! = 1
    /// Show bottom line of tab bar or not (default: 'false')
    var isShowBottomLine: Bool! = false
    
    /// Each button has the same width or not (default: 'false'. If it's 'YES', the 'buttonWidth' must be set, default is 100)
    var isUnifiedWidth: Bool! = false
    /// Has bounces effect or not (default: 'false')
    var isBounces: Bool! = false
    /// Tab bar can be scrolled or not (default: 'true')
    var isScrollable: Bool! = true
    
    private var navHeight: CGFloat! = 64
    /// The index of last page that opened.
    private var previousPage: Int!
    
    let isIphoneX: Bool = {
    
        return UIScreen.main.bounds.height >= 812
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavHeight()
    }
}

extension DJTabBarController {
    
    private func setNavHeight() {
        
        navHeight = isIphoneX ? navHeight+24 : navHeight
    }
    
    private func addScrollTabBar() {
        
        scrollTabBar = DJScrollTabBar(frame: CGRect(x: CGFloat(0), y: navHeight, width: dj_screenWidth, height: tabBarHeight))
        scrollTabBar.delegate = self
        
        view.addSubview(scrollTabBar)
    }
    
    private func addTableViews() {
        
        for i in 0..<tabItemArray.count {
            
            let view = tableViewArray[i]
            
            let leftOffset = CGFloat(i) * dj_screenWidth
            
            view.frame = CGRect(x: leftOffset, y: CGFloat(0), width: dj_screenWidth, height: scrollView.frame.size.height)
            
            scrollView.addSubview(view)
        }
        
        scrollView.contentSize = CGSize(width: CGFloat(tableViewArray.count) * dj_screenWidth, height: 0)
    }
    
    private func setupColors() {
        
        scrollTabBar.normalTitleColor       = normalTitleColor
        scrollTabBar.currentTitleColor      = currentTitleColor
        scrollTabBar.normalButtonBgColor    = normalButtonBgColor
        scrollTabBar.currentButtonBgColor   = currentButtonBgColor
        scrollTabBar.backgroundColor        = tabBarBgColor
        scrollTabBar.indicatorLineColor     = indicatorLineColor == nil ? currentTitleColor : indicatorLineColor
        scrollTabBar.bottomLineColor        = bottomLineColor
    }
    
    private func setupButtonWidth() {
        
        scrollTabBar.isUnifiedWidth = isUnifiedWidth
        scrollTabBar.buttonWidth    = buttonWidth <= 0 && isUnifiedWidth ? 100 : buttonWidth
    }
    
    private func setupMargins() {
        
        scrollTabBar.buttonMargin   = buttonMargin
        scrollTabBar.leftMargin     = leftMargin
        scrollTabBar.rightMargin    = rightMargin
    }
    
    private func setupDefaults() {
        
        scrollTabBar.isBounces                  = isBounces
        scrollTabBar.scrollView.isScrollEnabled = isScrollable
        scrollTabBar.tabBarHeight               = tabBarHeight
    }
    
    private func setupLine() {
        // indicator line
        scrollTabBar.indicatorLineHeight        = indicatorLineHeight
        scrollTabBar.indicatorLineWidth         = indicatorLineWidth
        scrollTabBar.isIndicatorLineInCenter    = isIndicatorLineInCenter
        scrollTabBar.isShowIndicatorLine        = isShowIndicatorLine
        // bottom line of tab bar
        scrollTabBar.bottomLineHeight           = bottomLineHeight
        scrollTabBar.isShowBottomLine           = isShowBottomLine
    }
    
    private func setupFonts() {
        
        scrollTabBar.normalTitleFont = normalTitleFont
        scrollTabBar.currentTitleFont = currentTitleFont == nil ? scrollTabBar.normalTitleFont : currentTitleFont
    }
}


extension DJTabBarController: DJScrollTabBarDelegate {
    
    @objc func didClickTabButton(tabBar: DJScrollTabBar, tabButton: UIButton) -> Bool {
        
        // If this method is invoked when you scroll the main scrollView, just return 'YES'.
        // Otherwise, the main scrollView will be scrolled again.
        if tabBar.isFromScrollTable {
            return true
        }
        // Scroll to a sub tableView according to the button selected in the tab bar.
        scrollView.setContentOffset(CGPoint(x: CGFloat(tabButton.tag) * dj_screenWidth, y: 0), animated: true)
        // Set index of the current page.
        currentPage = tabButton.tag
        
        return false
    }
}

extension DJTabBarController: UIScrollViewDelegate {
    
    @objc func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        currentPage = Int(scrollView.contentOffset.x / dj_screenWidth)
        
        if previousPage == currentPage {
            return
        }
        // Select the tab button accordingly.
        // Get current tab button.
        let currentTabButton: UIButton = scrollTabBar.scrollView.subviews[currentPage] as! UIButton
        // Set 'fromScrollTable' to 'true'.
        scrollTabBar.isFromScrollTable = true
        // Select current tab button.
        scrollTabBar.clickTabButton(button: currentTabButton)
        // Store 'currentPage' to 'previousPage'
        previousPage = currentPage
    }
}


extension DJTabBarController {
    /// Click a button in the tab bar according to a 'index'
    func clickButtonAt(index: Int) {
        
        scrollTabBar.clickButtonAt(index: index)
    }
}
