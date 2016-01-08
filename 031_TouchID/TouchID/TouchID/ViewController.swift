//
//  ViewController.swift
//  TouchID
//
//  Created by javan.chen on 2016/1/8.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var secret: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "adjustForKeyboard:", name: UIKeyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: "adjustForKeyboard:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: "saveSecretMessage", name: UIApplicationWillResignActiveNotification, object: nil)
        
        title = "Nothing to see here"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func adjustKeyboard(notification: NSNotification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let keyboardViewEndFrame = view.convertRect(keyboardScreenEndFrame, fromView: view.window)
        
        if notification.name == UIKeyboardWillHideNotification {
            secret.contentInset = UIEdgeInsetsZero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }
    
    @IBAction func authenticateUser(sender: AnyObject) {
        unlockSecretMessage()
    }
    
    func unlockSecretMessage() {
        secret.hidden = false
        title = "Secret stuff!"
        
        if let text = KeychainWrapper.stringForKey("SecretMessage") {
            secret.text = text
        }
    }
    
    func saveSecretMessage() {
        if !secret.hidden {
            KeychainWrapper.setString(secret.text, forKey: "SectetMessage")
            secret.resignFirstResponder()
            secret.hidden = true
            title = "Nothing to see here"
        }
    }
}

