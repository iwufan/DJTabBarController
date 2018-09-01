//
//  DJViewController.swift
//  DJTabBarController
//
//  Created by 贾大伟 on 2018/8/31.
//  Copyright © 2018 david. All rights reserved.
//

import UIKit

class DJViewController: DJTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.lightGray
        
        navigationItem.title = "A scrollable tab bar view controller"
        // set properties for tab bar
        setupTabbarProperties()
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
        // load data for tableviews, load data for the first tableview by default
        loadTableViewData()
    }
}

extension DJViewController {
    
    private func setupTabbarProperties() {
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
//        tabBarHeight                = 30;
        // button width
        isUnifiedWidth              = false;
//        buttonWidth               = 70;
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
        
    }
    /// Add all tableviews that need to display data
    private func setupSubviews() -> [DJTableView] {
        
        var typeTableViews = [DJTableView]()
        
        tabItemArray.forEach { (_) in
            let tableView = DJTableView()
            typeTableViews.append(tableView)
        }
        
        return typeTableViews
    }
}

extension DJViewController {
    
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
}


extension DJViewController {
    
    private func loadTableViewData() {
        
        guard let tableViewArray = tableViewArray else {
            return
        }
        
        let view: DJTableView = tableViewArray[currentPage] as! DJTableView
        view.typeID = "\(currentPage ?? 0)"
    }
}
