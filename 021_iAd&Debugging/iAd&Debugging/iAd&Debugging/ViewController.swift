//
//  ViewController.swift
//  iAd&Debugging
//
//  Created by javan.chen on 2015/11/12.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import iAd
import UIKit

class ViewController: UIViewController, ADBannerViewDelegate {
    var banerView: ADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        banerView = ADBannerView(adType: .Banner)
        banerView.translatesAutoresizingMaskIntoConstraints = false
        banerView.delegate = self
        banerView.hidden = true
        view.addSubview(banerView)
        
        let viewDictionary = ["bannerView": banerView]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[bannerView]|", options: [], metrics: nil, views: viewDictionary))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bannerView]|", options: [], metrics: nil, views: viewDictionary))
        
        assert(1 == 1, "Maths failure!")
//        assert(1 == 2, "Maths failure!")
        
        for i in 1 ... 100 {
            print("Got number \(i)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func bannerViewDidLoadAd(banner: ADBannerView!) {
        banerView.hidden = false
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        banerView.hidden = true
    }
}

