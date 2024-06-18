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
    
    func populate(myDiary: MyDiaryItem) {
        self.dateLabel.text = .convertDateString(myDiary.date)
        self.emotionImageView.image = myDiary.myDiaryMood.moodImage
        switch myDiary.myDiaryMood {
        case .good:
            self.borderView.addBorderAndColor(color: .soliuBlue, width: 1, corner_radius: 8)
        case .bad:
            self.borderView.addBorderAndColor(color: .diaryRedBorder, width: 1, corner_radius: 8)
        }
       
    }
}
