//
//  SelectionCell.swift
//  Plank ON
//
//  Created by 하동훈 on 2021/03/11.
//

import UIKit

class ChoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var gradeImageView: UIImageView!
    @IBOutlet weak var gradeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    func setUI() {
        backView.layer.cornerRadius = backView.frame.height / 10
        
        addShadow()
    }
    
    func addShadow() {
        gradeImageView.clipsToBounds = false
        gradeImageView.layer.shadowColor = UIColor.black.cgColor
        gradeImageView.layer.shadowOpacity = 1
        gradeImageView.layer.shadowOffset = .zero
        gradeImageView.layer.shadowRadius = 10
        gradeImageView.layer.shadowPath = UIBezierPath(roundedRect: gradeImageView.bounds, cornerRadius: backView.frame.height / 10).cgPath
    }
}
