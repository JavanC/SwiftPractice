//
//  ActionViewController.swift
//  Extension
//
//  Created by javan.chen on 2015/11/4.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let inputItem = extensionContext!.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first as? NSItemProvider {
                itemProvider.loadItemForTypeIdentifier(kUTTypePropertyList as String, options: nil) { [unowned self] (dict,error) in
                    //do stuff!
                }
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
    }
    
}

