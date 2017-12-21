//
//  ViewController.swift
//  TableCustomRefreshControl
//
//  Created by Prateek Sharma on 20/12/17.
//  Copyright © 2017 Prateek Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = UIColor.customBlue
        
        let bodyView = UIView()
        bodyView.frame = self.view.frame
        bodyView.frame.y += 20 + 44
        bodyView.frame.height -= (20 + 44)
        self.view.addSubview(bodyView)

//        tableView = SampleTableView(frame: self.view.frame, style: .plain)
//
//        tableView.delegate = self
//        tableView.dataSource = self
        
        tableView.frame.size.width = self.view.bounds.size.width
        
        let tableViewWrapper = PullToBounceWrapper(scrollView: tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableViewWrapper.addConstraint(NSLayoutConstraint(item: tableView, attribute: .centerX, relatedBy: .equal, toItem: tableViewWrapper, attribute: .centerX, multiplier: 1, constant: 0))
        tableViewWrapper.addConstraint(NSLayoutConstraint(item: tableView, attribute: .centerY, relatedBy: .equal, toItem: tableViewWrapper, attribute: .centerY, multiplier: 1, constant: 0))
        tableViewWrapper.addConstraint(NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: tableViewWrapper, attribute: .height, multiplier: 1, constant: 0))
        tableViewWrapper.addConstraint(NSLayoutConstraint(item: tableView, attribute: .width, relatedBy: .equal, toItem: tableViewWrapper, attribute: .width, multiplier: 1, constant: 0))
        
        bodyView.addSubview(tableViewWrapper)
        tableViewWrapper.translatesAutoresizingMaskIntoConstraints = false
        bodyView.addConstraint(NSLayoutConstraint(item: tableViewWrapper, attribute: .centerX, relatedBy: .equal, toItem: bodyView, attribute: .centerX, multiplier: 1, constant: 0))
        bodyView.addConstraint(NSLayoutConstraint(item: tableViewWrapper, attribute: .centerY, relatedBy: .equal, toItem: bodyView, attribute: .centerY, multiplier: 1, constant: 0))
        bodyView.addConstraint(NSLayoutConstraint(item: tableViewWrapper, attribute: .height, relatedBy: .equal, toItem: bodyView, attribute: .height, multiplier: 1, constant: 0))
        bodyView.addConstraint(NSLayoutConstraint(item: tableViewWrapper, attribute: .width, relatedBy: .equal, toItem: bodyView, attribute: .width, multiplier: 1, constant: 0))
        
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: bodyView, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: bodyView, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: bodyView, attribute: .top, multiplier: 1, constant: -64))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: bodyView, attribute: .width, multiplier: 1, constant: 0))
        
        
        tableView.reloadData()
        tableViewWrapper.didPullToRefresh = {
            Timer.schedule(delay: 5) { timer in
                tableViewWrapper.stopLoadingAnimation()
            }
        }

        makeMock()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SampleCell
//        cell.textLabel?.text = "Cell \(indexPath.row)"
        
        if cell.tag != 11 {
//            cell.tag = 11
            cell.setupView()
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func makeMock() {
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 64)
        headerView.backgroundColor = UIColor.lightBlue
        self.view.addSubview(headerView)
        
        let headerLine = UIView()
        headerLine.frame = CGRect(x: 0, y: 0, width: 120, height: 8)
        headerLine.layer.cornerRadius = headerLine.frame.height/2
        headerLine.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        headerLine.center = CGPoint(x: headerView.frame.center.x, y: 20 + 44/2)
        headerView.addSubview(headerLine)
    }
    
}


