//
//  CharacteristicCell.swift
//  CoreBluetoothTest
//
//  Created by Javan.Chen on 2017/1/4.
//  Copyright © 2017年 Javan.Chen. All rights reserved.
//

import UIKit

class CharacteristicCell: UITableViewCell {

    @IBOutlet weak var lbDESC: UILabel!
    @IBOutlet weak var lbProp: UILabel!
    @IBOutlet weak var lbValue: UILabel!
    @IBOutlet weak var lbNotifying: UILabel!
    @IBOutlet weak var lbUUID: UILabel!
    @IBOutlet weak var lbPropertyContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
