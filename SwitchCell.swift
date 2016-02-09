//
//  SwitchCell.swift
//  Yelp
//
//  Created by Jamel Peralta Coss on 2/8/16.
//  Copyright © 2016 Jamel Peralta. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate{
    optional func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    
    weak var delegate: SwitchCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func selectSwitch(sender: AnyObject) {
        print("switch off")
        if delegate != nil{
            delegate!.switchCell?(self, didChangeValue: onSwitch.on)
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
