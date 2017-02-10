//
//  BeaconDetailViewController.swift
//  DetectBeacon
//
//  Created by Javan.Chen on 2017/2/10.
//  Copyright © 2017年 Javan chen. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconDetailViewController: UIViewController, BeaconViewControllerDelegate {
    
    @IBOutlet weak var bluetoothUUIDLabel: UILabel!
    @IBOutlet weak var beaconNameLabel: UILabel!
    @IBOutlet weak var beaconUUIDLabel: UILabel!
    @IBOutlet weak var beaconMajorLabel: UILabel!
    @IBOutlet weak var beaconMinorLabel: UILabel!
    @IBOutlet weak var beaconRSSILabel: UILabel!
    @IBOutlet weak var beaconDistanceLabel: UILabel!
    @IBOutlet weak var beaconProximityLabel: UILabel!
    @IBOutlet weak var lightButton: UIButton!
    @IBOutlet weak var debugTextView: UITextView!
    
    var beaconData: BeaconData!
    var vc: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bluetoothUUIDLabel.text = beaconData.bleUUID.uuidString
        self.beaconNameLabel.text = beaconData.name
        self.beaconUUIDLabel.text = beaconData.uuid.uuidString
        self.beaconMajorLabel.text = beaconData.major.stringValue
        self.beaconMinorLabel.text = beaconData.minor.stringValue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vc.delegate = self
    }

    @IBAction func saveActionBarButton(_ sender: UIBarButtonItem) {
    }
    
    // MARK: - BeaconViewController Delegate
    func beaconsDataUpdate(beacons: [CLBeacon]) {
        if let beacon = beacons.filter({ $0.minor == beaconData.minor }).first {
            self.beaconRSSILabel.text = String(beacon.rssi)
            self.beaconDistanceLabel.text = String(format:"%.2f", beacon.accuracy) + " m"
            self.beaconProximityLabel.text = String(describing: beacon.proximity)
        }
    }
}
