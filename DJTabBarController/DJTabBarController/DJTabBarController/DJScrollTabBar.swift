//
//  DJScrollTabBar.swift
//  DJTabBarController
//
//  Created by 贾大伟 on 2018/8/30.
//  Copyright © 2018 david. All rights reserved.
//

import UIKit

protocol DJScrollTabBarDelegate {
    
    func didClickTabButton(tabBar: DJScrollTabBar, tabButton: UIButton)
}

/// A scrollable tab bar.
class DJScrollTabBar: UIView {
    
    /// The container of tabBar buttons
    var scrollView: UIScrollView!
    /// The array of all tab items
    var tabItemArray: Array<UIButton>!
    
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
    
    /// The margin between buttons (default: 0)
    var buttonMargin: Float! = 0
    /// The margin between the tab bar's left side and the first button's left side (default: 0)
    var leftMargin: Float! = 0
    /// The margin between the tab bar's right side and the last button's right side (default: the same with 'leftMargin')
    var rightMargin: Float! = 0
    /// The height of tab bar (default: 40, the same with buttons' height)
    var tabBarHeight: Float! = 40
    /// The width of buttons. (default: 100. if 'unifiedWidth' is 'NO', no need to set this property)
    var buttonWidth: Float! = 100
    
    /// The color of indicator line (default: the same with 'currentTitleColor')
    var indicatorLineColor: UIColor?
    /// The width of indicator line (default: the same with button's width)
    var indicatorLineWidth: Float?
    /// The height of indicator line (default: 1)
    var indicatorLineHeight: Float! = 1
    /// The indicator line is in the center or not (default: false)
    var isIndicatorLineInCenter: Bool! = false
    /// Show indicator line or not (default: 'false')
    var isShowIndicatorLine: Bool! = false
    
    /// The color of bottom line of tab bar (default: 'lightGray')
    var bottomLineColor: UIColor! = UIColor.lightGray
    /// The height of bottom line of tab bar (default: 1)
    var bottomLineHeight: Float! = 1
    /// Show bottom line of tab bar or not (default: 'false')
    var isShowBottomLine: Bool! = false
    
    /// Each button has the same width or not (default: 'false'. If it's 'YES', the 'buttonWidth' must be set, default is 100)
    var isUnifiedWidth: Bool! = false
    /// Has bounces effect or not (default: 'false')
    var isBounces: Bool! = false
    /// Scroll table view to select tabbar button or not
    var isFromScrollTable: Bool! = false
    
    private var selectedButton: UIButton?
    private lazy var lineDict: Dictionary<String, UIView>! = {
        
        return Dictionary()
    }()
    private var buttonArray: Array<UIButton>
    
    var delegate: DJScrollTabBarDelegate!
}

extension DJScrollTabBar {
    
    func clickTabButton(button: UIButton) {
        
    }
    
    func clickButtonAtIndex(index: Int) {
        
    }
}
