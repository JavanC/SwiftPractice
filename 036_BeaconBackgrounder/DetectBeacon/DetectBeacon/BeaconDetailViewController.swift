//
//  BeaconDetailViewController.swift
//  DetectBeacon
//
//  Created by Javan.Chen on 2017/2/10.
//  Copyright © 2017年 Javan chen. All rights reserved.
//

import UIKit
import CoreLocation
//import CoreBluetooth

class BeaconDetailViewController: UIViewController, BeaconViewControllerDelegate, BluetoothManagerDelegate {
    
    @IBOutlet weak var bleUUIDTextField: UITextField!
    @IBOutlet weak var beaconUUIDTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var majorTextFirld: UITextField!
    @IBOutlet weak var minorTextField: UITextField!
    @IBOutlet weak var rssiLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var proximityLabel: UILabel!
    @IBOutlet weak var lightSwitchButton: UIButton!
    @IBOutlet weak var debugTextView: UITextView!
    
    var beaconIndex: Int!
    var beaconData: BeaconData!
    var vc: ViewController!
//    var isLightOn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bleUUIDTextField.text = beaconData.bleUUID.uuidString
        self.beaconUUIDTextField.text = beaconData.uuid.uuidString
        self.nameTextField.text = beaconData.name
        self.majorTextFirld.text = beaconData.major.stringValue
        self.minorTextField.text = beaconData.minor.stringValue
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    
        BluetoothManager.sharedInstance.initialization()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vc.delegate = self
        BluetoothManager.sharedInstance.delegate = self
        
        self.debugTextView.text = ""
        DispatchQueue.main.asyncAfter(deadline: 0.5) {
            BluetoothManager.sharedInstance.readLightStatue(beaconData: beaconData)
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.lightSwitchButton.layer.cornerRadius = lightSwitchButton.frame.width / 2
        self.lightSwitchButton.layer.borderWidth = 3
        self.lightSwitchButton.layer.borderColor = UIColor.green.cgColor
        self.lightSwitchButton.layer.masksToBounds = true
    }
    
    // TextFieldEditingChangeed
    
    @IBAction func textFieldEditingDidEnd(_ sender: UITextField) {
        if sender.text == "" { return }
        if sender == bleUUIDTextField {
            beaconData.bleUUID = UUID(uuidString: bleUUIDTextField.text!)!
        } else if sender == beaconUUIDTextField {
            beaconData.uuid = UUID(uuidString: beaconUUIDTextField.text!)
        } else if sender == nameTextField {
            beaconData.name = nameTextField.text
        } else if sender == majorTextFirld {
            if let myInteger = Int(majorTextFirld.text!) {
                beaconData.major = NSNumber(value:myInteger)
            }
        } else if sender == minorTextField {
            if let myInteger = Int(minorTextField.text!) {
                beaconData.major = NSNumber(value:myInteger)
            }
        }
    }
    
    // MARK: - Button Event
    
    @IBAction func saveActionBarButton(_ sender: UIBarButtonItem) {
        BeaconsManager.sharedInstance.beacons[beaconIndex] = beaconData
    }
    
    @IBAction func actionLightSwitchButton(_ sender: UIButton) {
        BluetoothManager.sharedInstance.changeLightStatus(beaconData: beaconData, isLightOn: true)
    }

    // MARK: - BeaconViewController Delegate
    
    func beaconsDataUpdate(beacons: [CLBeacon]) {
        if let beacon = beacons.filter({ $0.minor == beaconData.minor }).first {
            self.rssiLabel.text = String(beacon.rssi)
            self.distanceLabel.text = String(format:"%.2f", beacon.accuracy) + " m"
            switch beacon.proximity {
            case .unknown:
                self.proximityLabel.text = "Unknown"
            case .immediate:
                self.proximityLabel.text = "Immediate"
            case .near:
                self.proximityLabel.text = "Near"
            case .far:
                self.proximityLabel.text = "Far"
            }
        }
    }
    
    // MARK: - BluetoothManager Delegate
    
    func debugLogUpdate(debugLog: String) {
        print(debugLog)
        debugTextView.text.append(debugLog)
    }
}
