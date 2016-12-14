//
//  BeaconView.swift
//  DetectBeacon
//
//  Created by Javan.Chen on 2016/12/14.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconView : UIView {
    
    var name: String?
    var nameLabel: UILabel!
    var proximityLabel: UILabel!
    var distanceLabel: UILabel!
    
    init(frame: CGRect, name: String) {
        self.name = name
        super.init(frame: frame)
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = UIColor.white
        
        self.nameLabel = UILabel(frame: CGRect(x: 0, y: frame.height / 2 - 50, width: frame.width, height: 30))
        self.nameLabel.textAlignment = NSTextAlignment.center
        self.nameLabel.font = UIFont.systemFont(ofSize: 25)
        self.nameLabel.text = "- \(name) -"
        self.addSubview(nameLabel)
        
        self.proximityLabel = UILabel(frame: CGRect(x: 0, y: frame.height / 2 - 20, width: frame.width, height: 40))
        self.proximityLabel.textAlignment = NSTextAlignment.center
        self.proximityLabel.font = UIFont.systemFont(ofSize: 30)
        self.proximityLabel.text = "UNKNOWN"
        self.addSubview(proximityLabel)
        
        self.distanceLabel = UILabel(frame: CGRect(x: 0, y: frame.height / 2 + 20, width: frame.width, height: 30))
        self.distanceLabel.textAlignment = NSTextAlignment.center
        self.distanceLabel.font = UIFont.systemFont(ofSize: 25)
        self.distanceLabel.text = "0 m"
        self.addSubview(distanceLabel)
        
        return
    }
    
    func updateBeaconData(proximity: CLProximity, distance: Double) {
        self.distanceLabel.text = String(format:"%.2f", distance) + " m"
        switch proximity {
        case .unknown:
            proximityLabel.text = "UNKNOWN"
            self.backgroundColor = UIColor.gray
        case .far:
            proximityLabel.text = "FAR"
            self.backgroundColor = UIColor.blue
        case .near:
            proximityLabel.text = "NEAR"
            self.backgroundColor = UIColor.yellow
        case .immediate:
            proximityLabel.text = "IMMEDIATE"
            self.backgroundColor = UIColor.red
        }
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
