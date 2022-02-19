//
//  HourlyCell.swift
//  WeatherTrail
//
//  Created by comviva on 16/02/22.
//

import UIKit

class HourlyCell: UITableViewCell {

    @IBOutlet weak var hourL: UILabel!

    @IBOutlet weak var tempCellL: UILabel!
    
    @IBOutlet weak var conditionsL: UIImageView!
    @IBOutlet weak var humidityL: UILabel!
    @IBOutlet weak var feelLikeL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
