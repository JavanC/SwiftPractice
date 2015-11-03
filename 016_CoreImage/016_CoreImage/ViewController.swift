//
//  ViewController.swift
//  016_CoreImage
//
//  Created by javan.chen on 2015/10/30.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var intensity: UISlider!
    @IBAction func ChangeFilter(sender: UIButton) {
    }
    @IBAction func save(sender: UIButton) {
    }
    @IBAction func intensityChanged(sender: UISlider) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

