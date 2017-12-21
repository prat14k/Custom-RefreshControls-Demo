//
//  ViewController.swift
//  PullToRefreshAction
//
//  Created by Prateek Sharma on 21/12/17.
//  Copyright © 2017 Prateek Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var labelsArray: [UILabel]!
    var refreshControl: UIRefreshControl!
    @IBOutlet var customView: UIView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.clear
        refreshControl.backgroundColor = UIColor.clear
        tableView.addSubview(refreshControl)
        
//        customView.frame = refreshControl.bounds
        refreshControl.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.addConstraint(NSLayoutConstraint(item: customView, attribute: .leading, relatedBy: .equal, toItem: refreshControl, attribute: .leading, multiplier: 1, constant: 0))
        refreshControl.addConstraint(NSLayoutConstraint(item: customView, attribute: .trailing, relatedBy: .equal, toItem: refreshControl, attribute: .trailing, multiplier: 1, constant: 0))
        refreshControl.addConstraint(NSLayoutConstraint(item: customView, attribute: .top, relatedBy: .equal, toItem: refreshControl, attribute: .top, multiplier: 1, constant: 0))
        refreshControl.addConstraint(NSLayoutConstraint(item: customView, attribute: .bottom, relatedBy: .equal, toItem: refreshControl, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "Cell \(indexPath.row)"
        
        return cell
    }
}

