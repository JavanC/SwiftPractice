//
//  ViewController.swift
//  Tap Me
//
//  Created by javan.chen on 2015/10/16.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var count = 0
    var seconds = 0
    var timer = NSTimer()
    
    
    
    @IBAction func buttonPress(sender: AnyObject) {
        count++
        scoreLabel.text = "Score \n\(count)"
    }
    
    func setupGame() {
        seconds = 30
        count = 0
        
        timerLabel.text = "Time: \(seconds)"
        scoreLabel.text = "Score: \(count)"
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func subtractTime() {
        seconds--
        timerLabel.text = "Time: \(seconds)"
        if(seconds == 0) {
            timer.invalidate()
            let alert = UIAlertController(title: "Time is up!", message: "You scored \(count) point", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {action in self.setupGame()}))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
}

