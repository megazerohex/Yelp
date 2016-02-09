//
//  BusinessCell.swift
//  Yelp
//
//  Created by Jamel Peralta Coss on 2/7/16.
//  Copyright © 2016 Jamel Peralta. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    
    //Pictures
    @IBOutlet weak var businessPicture: UIImageView!
    @IBOutlet weak var ratingView: UIImageView!
    //Labels
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    var business: Business!{
        didSet{
            businessPicture.setImageWithURL(business.imageURL!)
            ratingView.setImageWithURL(business.ratingImageURL!)
            
            businessNameLabel.text = business.name
            ratingLabel.text = "\(business.reviewCount!) Reviews"
            distanceLabel.text = business.distance
            addressLabel.text = business.address
            categoriesLabel.text = business.categories
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Change the Layer of the ImageView
        businessPicture.layer.cornerRadius = 4
        businessPicture.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
