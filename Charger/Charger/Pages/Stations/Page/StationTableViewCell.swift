//
//  StationTableViewCell.swift
//  Charger
//
//  Created by Ceren Yaşa on 14.07.2022.
//

import UIKit

class StationTableViewCell: UITableViewCell {
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var serviceHours: UILabel!
    @IBOutlet weak var kwLabel: UILabel!
    @IBOutlet weak var socketCount: UILabel!
    let separator = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
