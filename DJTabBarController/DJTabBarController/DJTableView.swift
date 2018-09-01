//
//  DJTableView.swift
//  DJTabBarController
//
//  Created by 贾大伟 on 2018/8/31.
//  Copyright © 2018 david. All rights reserved.
//

import UIKit

class DJTableView: UIView {

    var typeID: String! {
        didSet {
            loadData()
        }
    }
    private lazy var tableView: UITableView! = {
        
        let tableView = UITableView(frame: bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        
        addSubview(tableView)
        
        return tableView
    }()
    
    private lazy var dataArray: [String]! = {
    
        return [String]()
    }()
}

extension DJTableView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "cell"
        
        var cell = tableView .dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        
        cell?.textLabel?.text = dataArray[indexPath.row]
        
        return cell!
    }
}

extension DJTableView {
    /// simulate loading data from the server
    private func loadData() {
        
        if dataArray.count != 0 {
            dataArray.removeAll()
        }
        
        var tempArray = [String]()
        let titleArray = ["Military", "Games", "Societies", "Sports", "Entertainment", "Headline", "Women", "Politics", "Fashion"]
        
        for i in 0..<20 {
            let string = String(format: "%@ - %d", titleArray[Int(typeID)!], i)
            tempArray.append(string)
        }
        
        dataArray = tempArray
        
        tableView.reloadData()
    }
}
