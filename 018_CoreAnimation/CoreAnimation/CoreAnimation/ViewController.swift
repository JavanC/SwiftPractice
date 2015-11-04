//
//  ViewController.swift
//  CoreAnimation
//
//  Created by javan.chen on 2015/11/4.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var imageView: UIImageView!
    var currentAnimation = 0
    
    @IBOutlet weak var tap: UIButton!
    @IBAction func tapped(sender: UIButton) {
        ++currentAnimation
        
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

