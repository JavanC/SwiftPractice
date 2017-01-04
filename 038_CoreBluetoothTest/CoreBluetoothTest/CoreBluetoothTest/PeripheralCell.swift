//
//  PeripheralCell.swift
//  CoreBluetoothTest
//
//  Created by Javan.Chen on 2017/1/4.
//  Copyright © 2017年 Javan.Chen. All rights reserved.
//

import UIKit

class PeripheralCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbUUID: UILabel!
    @IBOutlet weak var lbRSSI: UILabel!
    @IBOutlet weak var lbDist: UILabel!
    @IBOutlet weak var lbIsConnectable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
