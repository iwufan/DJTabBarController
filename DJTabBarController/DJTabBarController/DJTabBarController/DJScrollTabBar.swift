//
//  DJScrollTabBar.swift
//  DJTabBarController
//
//  Created by 贾大伟 on 2018/8/30.
//  Copyright © 2018 david. All rights reserved.
//

import UIKit

let dj_screenWidth = UIScreen.main.bounds.width

protocol DJScrollTabBarDelegate {
    
    func didClickTabButton(tabBar: DJScrollTabBar, tabButton: UIButton) -> Bool
}

/// A scrollable tab bar.
class DJScrollTabBar: UIView {
    
    /// The container of tabBar buttons
    lazy var scrollView: UIScrollView! = {
       
        let scrollView = UIScrollView(frame: bounds)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = isBounces
        
        addSubview(scrollView)
        
        return scrollView
    }()
    /// The array of all tab items
    var tabItemArray: [String]! {
        didSet {
            
            addTabButton(tabItemArray: tabItemArray)
            addBottomLine()
        }
    }
    
    /// The font of buttons in normal status (default: "normal, 14")
    var normalTitleFont: UIFont! = UIFont.systemFont(ofSize: 14)
    /// The font of buttons in selected status (default: the same with 'normalFont')
    var currentTitleFont: UIFont!
    
    /// The title color of buttons in normal status (default: 'black')
    var normalTitleColor: UIColor! = UIColor.black
    /// The title color of buttons in selected status (default: 'orange')
    var currentTitleColor: UIColor! = UIColor.orange
    /// The background color of buttons in normal status (default: 'white')
    var normalButtonBgColor: UIColor! = UIColor.white
    /// The background color of buttons in selected status (default: 'white')
    var currentButtonBgColor: UIColor! = UIColor.white
    
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
    /// Scroll table view to select tabbar button or not
    var isFromScrollTable: Bool! = false
    /// The current selected button
    private var selectedButton: UIButton?
    /// Store the indicator line of each tabbar button
    private lazy var lineDict: [Int: UIView]! = {
        
        return [Int: UIView]()
    }()
    /// All tabbar buttons
    private lazy var buttonArray: [UIButton]! = {
        
        return [UIButton]()
    }()
    
    var delegate: DJScrollTabBarDelegate!
}

extension DJScrollTabBar {
    
    private func addBottomLine() {
        
        if self.isShowBottomLine {
            
            let line = UIView()
            line.backgroundColor = bottomLineColor
            line.frame = CGRect(x: CGFloat(0), y: tabBarHeight - bottomLineHeight, width: bounds.size.width, height: bottomLineHeight)
            
            self.addSubview(line)
        }
    }
    
    private func addTabButton(tabItemArray: [String]) {
        
        guard tabItemArray.count != 0 else {
            return
        }
        
        var leftOffset: CGFloat = 0
        var sumbuttonWidth: CGFloat = 0
        
        for i in 0..<tabItemArray.count {
            
            let tabButton = UIButton()
            tabButton.setTitle(tabItemArray[i], for: .normal)
            tabButton.setTitleColor(normalTitleColor, for: .normal)
            tabButton.setTitleColor(currentTitleColor, for: .selected)
            tabButton.backgroundColor = normalButtonBgColor
            tabButton.titleLabel?.font = normalTitleFont
            tabButton.tag = i
            
            tabButton.addTarget(self, action: #selector(clickTabButtonOnTabBar(button:)), for: .touchUpInside)
            
            var tempButtonWidth: CGFloat = 0
            
            if !isUnifiedWidth {
                // If all button's width are not the same, then use the button's title's width as the button's width
                tempButtonWidth = tabItemArray[i].boundingRect(with: CGSize(width: dj_screenWidth - 2 * leftMargin, height: tabBarHeight),options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: currentTitleFont], context:nil).size.width
            } else {
                // If all button's width are the same. Default is 100.
                tempButtonWidth = buttonWidth
            }
            
            sumbuttonWidth += tempButtonWidth   // The sum of all buttons' width
            
            leftOffset = leftMargin + sumbuttonWidth + buttonMargin * CGFloat(i) - tempButtonWidth
            
            tabButton.frame = CGRect(x: leftOffset, y: CGFloat(0), width: tempButtonWidth, height: tabBarHeight)
            
            scrollView.addSubview(tabButton)
            buttonArray.append(tabButton)
            
//            if isShowIndicatorLine {
            
                let lineWidth = indicatorLineWidth <= CGFloat(0) ? tempButtonWidth : indicatorLineWidth
                
                let line = UIView()
                line.backgroundColor = indicatorLineColor
                line.isHidden = true
                
                let lineX = isIndicatorLineInCenter ? (tempButtonWidth - lineWidth!) / 2 : 0
                
                line.frame = CGRect(x: lineX, y: tabBarHeight, width: lineWidth!, height: indicatorLineHeight)
                
                tabButton.addSubview(line)
                
                lineDict[i] = line
//            }
            // calculate the sum of left offset
            leftOffset += tempButtonWidth
            // select the first tabbar button by default
            if i == 0 {
                
                clickTabButtonOnTabBar(button: tabButton)
            }
        }
        // set the contentSize of the scrollView
        let tempRightMargin = rightMargin > CGFloat(0) ? rightMargin : leftMargin
        scrollView.contentSize = CGSize(width: leftOffset + tempRightMargin!, height: 0)
    }
}

extension DJScrollTabBar {
    
    @objc private func clickTabButtonOnTabBar(button: UIButton) {
        
        isFromScrollTable = false
        
        clickTabButton(button: button)
    }
    /// Click a button in the tab bar according to a 'index'
    func clickButtonAt(index: Int) {
        
        let button = buttonArray[index]
        
        clickTabButtonOnTabBar(button: button)
    }
    /// Click a button in the tab bar.
    func clickTabButton(button: UIButton) {
        
        guard selectedButton != button else {
            return
        }
        
        if selectedButton != nil {
            selectedButton?.isSelected = false
            selectedButton?.backgroundColor = normalButtonBgColor
            
            let selectedLine: UIView = lineDict[(selectedButton?.tag)!]!
            selectedLine.isHidden = true
            
            selectedButton?.titleLabel?.font = normalTitleFont
        }
        
        button.isSelected = true
        button.backgroundColor = currentButtonBgColor
        
        let currentLine: UIView = lineDict[button.tag]!
        currentLine.isHidden = false
        
        button.titleLabel?.font = currentTitleFont
        
        selectedButton = button
        
        scrollTabBar(button: button)
        
        if let delegate = delegate {
            
            _ = delegate.didClickTabButton(tabBar: self, tabButton: button)
        }
    }
}

extension DJScrollTabBar {
    
    private func scrollTabBar(button: UIButton) {
        
        let maxWidth = button.frame.origin.x + button.frame.size.width
        
        if maxWidth > dj_screenWidth || dj_screenWidth - maxWidth < 30 {
            
            var offsetX = maxWidth - dj_screenWidth
            
            if button.tag < tabItemArray.count - 1 {
                
                offsetX += button.frame.size.width + 30
                
                if offsetX > scrollView.contentSize.width - dj_screenWidth {
                    
                    offsetX = scrollView.contentSize.width - dj_screenWidth
                }
            }
            
            if button.tag == tabItemArray.count - 1 {
                
                offsetX = scrollView.contentSize.width - dj_screenWidth
            }
            
            scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        } else {
            
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
}
