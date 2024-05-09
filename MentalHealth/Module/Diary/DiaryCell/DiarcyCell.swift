//
//  DiarcyCell.swift
//  MentalHealth
//
//  Created by Yoon on 5/8/24.
//

import UIKit

class DiarcyCell: UITableViewCell, CellReusable {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var emotionImageView: UIImageView!
    @IBOutlet weak var borderView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populate() {
        self.dateLabel.text = "March 12"
        self.emotionImageView.image = UIImage(emotionAssetIdentifier: .badIcon)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
