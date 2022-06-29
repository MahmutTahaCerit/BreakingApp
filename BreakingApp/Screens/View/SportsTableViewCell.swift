//
//  SportsTableViewCell.swift
//  BreakingApp
//
//  Created by Mahmut Taha Cerit on 29.06.2022.
//

import UIKit

class SportsTableViewCell: UITableViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
