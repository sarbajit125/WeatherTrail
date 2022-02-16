//
//  WeatherCell.swift
//  WeatherTrail
//
//  Created by comviva on 06/02/22.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var dayL: UILabel!
    
    @IBOutlet weak var maxT: UILabel!
    @IBOutlet weak var forecastImg: UIImageView!
    @IBOutlet weak var minT: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
