//
//  ViewController3.swift
//  CoreBluetoothTest
//
//  Created by Javan.Chen on 2017/1/4.
//  Copyright © 2017年 Javan.Chen. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController3: UIViewController, CBPeripheralDelegate {

    var char: CBCharacteristic!
    var peripheral: CBPeripheral!
    @IBOutlet weak var lbUUID: UILabel!
    @IBOutlet weak var lbPropHex: UILabel!
    @IBOutlet weak var lbProp: UILabel!
    @IBOutlet weak var btRead: UIButton!
    @IBOutlet weak var tvResponse: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
