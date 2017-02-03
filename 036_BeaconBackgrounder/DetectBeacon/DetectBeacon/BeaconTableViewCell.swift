//
//  BeaconTableViewCell.swift
//  DetectBeacon
//
//  Created by Javan.Chen on 2017/2/3.
//  Copyright © 2017年 Javan chen. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconTableViewCell: UITableViewCell {

    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var lightView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lightView.layer.cornerRadius = 4
        lightView.layer.masksToBounds = true
    }
    
    func updateBeaconData(proximity: CLProximity, distance: Double) {
        self.distanceLabel.text = String(format:"%.2f", distance) + " m"
        switch proximity {
        case .unknown:
            lightView.backgroundColor = UIColor.gray
        case .far:
            lightView.backgroundColor = UIColor.blue
        case .near:
            lightView.backgroundColor = UIColor.yellow
        case .immediate:
            lightView.backgroundColor = UIColor.red
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
