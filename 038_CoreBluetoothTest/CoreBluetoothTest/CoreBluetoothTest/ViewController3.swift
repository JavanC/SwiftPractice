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
    @IBOutlet weak var btWrite: UIButton!
    @IBOutlet weak var tvResponse: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        lbUUID.text = char.uuid.uuidString
        lbProp.text = char.getPropertyContent()
        lbPropHex.text = String(format: "0x%02X", char.properties.rawValue)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        peripheral.delegate = self
        if !char.isReadable() {
            btRead.isEnabled = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionRead(_ sender: UIButton) {
        peripheral.readValue(for: char)
    }
    @IBAction func onAction(_ sender: Any) {
        let rawArray:[UInt8] = [0xEF];
        let data = Data(bytes: rawArray)
        peripheral.writeValue(data, for: char, type: .withResponse)
    }
    @IBAction func offAction(_ sender: Any) {
        let rawArray:[UInt8] = [0xEE];
        let data = Data(bytes: rawArray)
        peripheral.writeValue(data, for: char, type: .withResponse)
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
    
        print(characteristic)
        if let value = characteristic.value {
            let log = "read: \((value as NSData).getByteArray()!)"
            tvResponse.text = log + "\n\n" + self.tvResponse.text
        }
    }
}
