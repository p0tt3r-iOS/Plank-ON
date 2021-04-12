//
//  SelectionCell.swift
//  Plank ON
//
//  Created by 하동훈 on 2021/03/11.
//

import UIKit

class ChoiceCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var gradeImageView: UIImageView!
    @IBOutlet weak var gradeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = backView.frame.height / 10
        gradeImageView.layer.cornerRadius = backView.frame.height / 10
    }
}
