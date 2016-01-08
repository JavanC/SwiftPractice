//
//  ViewController.swift
//  MyCoreGraphics
//
//  Created by javan.chen on 2016/1/8.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentDrawType = 0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func redrawTapped(sender: AnyObject) {
        
        if ++currentDrawType > 5 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
            
        default: break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRectangle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawRectangle() {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 512, height: 512), false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        let rectamgle = CGRect(x: 0, y: 0, width: 512, height: 512)
        
        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextSetLineWidth(context, 10)
        
        CGContextAddRect(context, rectamgle)
        CGContextDrawPath(context, .FillStroke)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        imageView.image = img
    }

    
}
