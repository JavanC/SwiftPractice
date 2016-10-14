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
    @IBOutlet weak var script: UITextView!
    
    var pageTitle = ""
    var pageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "done")
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "adjustForKeyboard:", name: UIKeyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: "adjustForKeyboard:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        if let inputItem = extensionContext!.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first as? NSItemProvider {
                itemProvider.loadItemForTypeIdentifier(kUTTypePropertyList as String, options: nil) { [unowned self] (dict, error) in
                    let itemDictionary = dict as! NSDictionary
                    let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as! NSDictionary
                    
                    self.pageTitle = javaScriptValues["title"] as! String
                    self.pageURL = javaScriptValues["URL"] as! String
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.title = self.pageTitle
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done() {
        let item = NSExtensionItem()
        let webDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: ["customJavaScript": script.text]]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        
        extensionContext!.completeRequestReturningItems([item], completionHandler: nil)
    }
    
    func adjustForKeyboard(notification: NSNotification) {
        //取得資訊
        let userInfo = notification.userInfo!
        //取得現在的工作的鍵盤大小
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        //轉會韋視窗座標，convertRect避免旋轉後大小改變
        let keyboardViewEndFrame = view.convertRect(keyboardScreenEndFrame, fromView: view.window)
        //調整script大小，如果鍵盤隱藏(外接鍵盤)，距離四邊0，如有鍵盤，改變距離底部為鍵盤高度
        if notification.name == UIKeyboardWillHideNotification {
            script.contentInset = UIEdgeInsetsZero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        //滾動script
        script.scrollIndicatorInsets = script.contentInset
        
//        let selectedRange = script.selectedRange
//        script.scrollRangeToVisible(selectedRange)
    }
}

