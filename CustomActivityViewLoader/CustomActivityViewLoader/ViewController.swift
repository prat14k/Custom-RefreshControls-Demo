//
//  ViewController.swift
//  CustomActivityViewLoader
//
//  Created by Prateek Sharma on 11/04/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var tableView: LoadingTableView!
    var counter = 30
    
    // MARK: tableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counter
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    }
    
    // MARK: view methods
    // Download the content from parse and display it
    func loadContent() {
        tableView.showLoadingIndicator()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5, execute: { [weak self] in
            self?.tableView.hideLoadingIndicator()
            self?.counter = 5
            self?.tableView.reloadData()
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadContent()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    
}

