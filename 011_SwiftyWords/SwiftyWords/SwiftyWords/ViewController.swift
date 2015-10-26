//
//  ViewController.swift
//  SwiftyWords
//
//  Created by javan.chen on 2015/10/26.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var letterButtons = [UIButton]()
    var activatedButten = [UIButton]()
    var solutions = [String]()
    
    var score = 0
    var level = 1
    
    @IBAction func submitTapped(sender: UIButton) {
    }
    @IBAction func clearTapped(sender: UIButton) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for subview in view.subviews where subview.tag == 1001 {
            let btn = subview as! UIButton
            letterButtons.append(btn)
            btn.addTarget(self, action: "letterTapped:", forControlEvents: .TouchUpInside)
        }
        loadLevel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        //讀取level1.txt路徑
        if let levelFilePath = NSBundle.mainBundle().pathForResource("level\(level)", ofType: "txt") {
            //根據路徑讀取內文
            if let levelContents = try? String(contentsOfFile: levelFilePath, usedEncoding: nil) {
                //根據“\n”符號 拆開成數行
                var lines = levelContents.componentsSeparatedByString("\n")
                //隨機排列行順序
                lines = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(lines) as! [String]
                //迴圈 line 數列的資料 每次迴圈將item放置到line 將位置放置到index
                for (index, line) in lines.enumerate() {
                    //根據": "符號拆開
                    let parts = line.componentsSeparatedByString(": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    //把answer的“|"替換成“” 儲存在solutionword
                    let solutionWord = answer.stringByReplacingOccurrencesOfString("|", withString: "")
                    //計算字母數量
                    solutionString += "\(solutionWord.characters.count) letters\n"
                    //儲存solutions
                    solutions.append(solutionWord)
                    //根據每個答案的”|"分隔 除純每個拼字部分
                    let bits = answer.componentsSeparatedByString("|")
                    letterBits += bits
                }
            }
        }
        
        cluesLabel.text = clueString.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
        answersLabel.text = solutionString.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
        
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(letterBits) as! [String]
        letterButtons = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(letterButtons) as! [UIButton]
        
        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterBits.count {
                letterButtons[i].setTitle(letterBits[i], forState: .Normal)
            }
        }
    }


}

