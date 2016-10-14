//
//  ViewController.swift
//  EncryptorMacOS
//
//  Created by javan.chen on 2015/10/15.
//  Copyright © 2015年 javan.chen. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var display: NSTextField!
    @IBOutlet weak var InPut: NSTextField!
    @IBOutlet weak var Output: NSTextField!
    
    var e:Encrypt?
    var inputText = ""
    var outputText = ""
    let filename = "encryptor"
    
    @IBAction func NewMethod(sender: AnyObject) {
        e = Encrypt()
        
        if e != nil {
            display.stringValue = e!.code.description
        }
    }
    @IBAction func LoadMethod(sender: AnyObject) {
        let isFileExist = NSFileManager.defaultManager().fileExistsAtPath(filename)
        if isFileExist {
            e = NSKeyedUnarchiver.unarchiveObjectWithFile(filename) as? Encrypt
            display.stringValue = "Encrypt object is loaded"
        }
        else {
            display.stringValue = "Encrypt object is not loaded"
        }
    }
    @IBAction func SaveMethod(sender: AnyObject) {
        let succed = NSKeyedArchiver.archiveRootObject(e!, toFile: filename)
        if succed {
            display.stringValue = "Encrypt object is saved"
        }
        else {
            display.stringValue = "Encrypt object is not saved"
        }
    }
    @IBAction func EncodeMethod(sender: AnyObject) {
        inputText = InPut.stringValue
        
        if inputText == "" {
            display.stringValue = "Please input somethinf"
        }
        else {
            if e != nil {
                outputText = e!.toEncode(inputText)
                Output.stringValue = outputText
                
                display.stringValue = "The reselt is above"
            }
            else {
                display.stringValue = "No Encrypt Object!"
            }
        }
    }
    @IBAction func DecodeMethod(sender: AnyObject) {
        inputText = InPut.stringValue
        
        if inputText == "" {
            display.stringValue = "Please input something"
        }
        else {
            if e != nil {
                outputText = e!.toDecode(inputText)
                Output.stringValue = outputText
                
                display.stringValue = "The reselt is above"
            }
            else {
                display.stringValue = "No Encrypt Object!"
            }
        }
    }
    @IBAction func CopyMethod(sender: AnyObject) {
        let pasteBoard = NSPasteboard.generalPasteboard()
        pasteBoard.clearContents()
        pasteBoard.writeObjects([outputText])
        display.stringValue = "The result is copies to clipoore"
    }
    @IBAction func ClearMethod(sender: AnyObject) {
        InPut.stringValue = ""
        Output.stringValue = ""
        e = nil
        inputText = ""
        outputText = ""
        
        display.stringValue = "It is all clear."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

