//
//  ViewController.swift
//  PullToRefreshAction
//
//  Created by Prateek Sharma on 21/12/17.
//  Copyright © 2017 Prateek Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var isAnimating = false
    var currentColorIndex = 0
    var currentLabelIndex = 0
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
        
        refreshControl.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.addConstraint(NSLayoutConstraint(item: customView, attribute: .leading, relatedBy: .equal, toItem: refreshControl, attribute: .leading, multiplier: 1, constant: 0))
        refreshControl.addConstraint(NSLayoutConstraint(item: customView, attribute: .trailing, relatedBy: .equal, toItem: refreshControl, attribute: .trailing, multiplier: 1, constant: 0))
        refreshControl.addConstraint(NSLayoutConstraint(item: customView, attribute: .top, relatedBy: .equal, toItem: refreshControl, attribute: .top, multiplier: 1, constant: 0))
        refreshControl.addConstraint(NSLayoutConstraint(item: customView, attribute: .bottom, relatedBy: .equal, toItem: refreshControl, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    func animateRefreshStep1() {
        isAnimating = true
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.labelsArray[self.currentLabelIndex].transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4))
            self.labelsArray[self.currentLabelIndex].textColor = self.getNextColor()
            
        }, completion: { (finished) -> Void in
            
            UIView.animate(withDuration: 0.05, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                self.labelsArray[self.currentLabelIndex].transform = CGAffineTransform.identity
                self.labelsArray[self.currentLabelIndex].textColor = UIColor.black
                
            }, completion: { (finished) -> Void in
                self.currentLabelIndex = self.currentLabelIndex + 1
                
                if self.currentLabelIndex < self.labelsArray.count {
                    self.animateRefreshStep1()
                }
                else {
                    self.animateRefreshStep2()
                }
            })
        })
    }
    
    func animateRefreshStep2() {
        UIView.animate(withDuration: 0.35, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            
            for label in self.labelsArray {
                label.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
            
        }, completion: { (finished) -> Void in
            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                for label in self.labelsArray {
                    label.transform = CGAffineTransform.identity
                }
            }, completion: { (finished) -> Void in
                if self.refreshControl.isRefreshing {
                    self.currentLabelIndex = 0
                    self.animateRefreshStep1()
                }
                else {
                    self.isAnimating = false
                    self.currentLabelIndex = 0
                    for label in self.labelsArray {
                        label.textColor = UIColor.black
                        label.transform = CGAffineTransform.identity
                    }
                }
            })
        })
    }
    
    func getNextColor() -> UIColor {
        var colorsArray: Array<UIColor> = [UIColor.magenta, UIColor.brown, UIColor.yellow, UIColor.red, UIColor.green, UIColor.blue, UIColor.orange]
        
        if currentColorIndex == colorsArray.count {
            currentColorIndex = 0
        }
        
        let returnColor = colorsArray[currentColorIndex]
        currentColorIndex = currentColorIndex + 1
        
        return returnColor
    }
    
    @objc func dismissRefreshControl(){
        refreshControl.endRefreshing()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl.isRefreshing {
            if !isAnimating {
                perform(#selector(dismissRefreshControl), with: nil, afterDelay: 4)
                animateRefreshStep1()
            }
        }
    }
}

