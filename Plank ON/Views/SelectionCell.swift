//
//  SelectionCell.swift
//  Plank ON
//
//  Created by 하동훈 on 2021/03/11.
//

import UIKit

class SelectionCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var gradeImageView: UIImageView!
    @IBOutlet weak var gradeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = backView.frame.height / 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
