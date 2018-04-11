//
//  LoadingTableView.swift
//  CustomActivityViewLoader
//
//  Created by Prateek Sharma on 11/04/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class LoadingTableView: UITableView {

    let loadingImage = UIImage(named: "loadingIndicator")
    var loadingImageView: UIImageView
    
    required init?(coder aDecoder: NSCoder) {
        loadingImageView = UIImageView(image: loadingImage)
        super.init(coder: aDecoder)
        addSubview(loadingImageView)
        adjustSizeOfLoadingIndicator()
    }
    
    
    // MARK: private methods
    // Adjust the size so that the indicator is always in the middle of the screen
    private func adjustSizeOfLoadingIndicator() {
        let loadingImageSize = loadingImage?.size
        loadingImageView.frame = CGRect(x: (frame.size.width/2) - (loadingImageSize!.width/2), y: frame.size.height/2-loadingImageSize!.height/2, width: loadingImageSize!.width, height: loadingImageSize!.height)
    }


    func showLoadingIndicator() {
        loadingImageView.isHidden = false
        self.bringSubview(toFront: loadingImageView)
        
        startRefreshing()
    }
    
    func hideLoadingIndicator() {
        loadingImageView.isHidden = true
        
        stopRefreshing()
    }
    
    override func reloadData() {
        super.reloadData()
        self.bringSubview(toFront: loadingImageView)
    }
    
    // MARK: private methods
    // Adjust the size so that the indicator is always in the middle of the screen
    override func layoutSubviews() {
        super.layoutSubviews()
        adjustSizeOfLoadingIndicator()
    }

    // Start the rotating animation
    private func startRefreshing() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.isRemovedOnCompletion = false
        animation.toValue = .pi * 2.0
        animation.duration = 0.8
        animation.isCumulative = true
        animation.repeatCount = Float.infinity
        loadingImageView.layer.add(animation, forKey: "rotationAnimation")
    }
    
    // Stop the rotating animation
    private func stopRefreshing() {
        loadingImageView.layer.removeAllAnimations()
    }
    
    
}
