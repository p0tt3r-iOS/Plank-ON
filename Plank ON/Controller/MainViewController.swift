//
//  ViewController.swift
//  Plank ON
//
//  Created by 하동훈 on 2021/03/11.
//

import UIKit

import CoreData

class MainViewController: UIViewController {

    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var goToTimerButton: UIButton!
    
    var progress = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addBottomBorder(width: 0.5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "My Plank"
        checkIsPlanSet()
        
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    
    private func addBottomBorder(width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = UIColor.systemGray4.cgColor
        border.frame = CGRect(x: 0,
                              y: progressView.frame.size.height - width,
                              width: progressView.frame.size.width,
                              height: width)
        progressView.layer.addSublayer(border)
    }
    
    func checkIsPlanSet() {
        if Plan.shared.isSet {
            goToTimerButton.isEnabled = true
            gradeLabel.text = Plan.shared.choice?.grade
            
            progress = Double(Plan.shared.day) / Double(28)
            
            progressLabel.text = "\(String(format: "%.1f", progress * 100))%"
        } else {
            goToTimerButton.isEnabled = false
        }
    }
    
    
}

// MARK: - UICollectionViewDataSource & Delegate Method

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionViewCell", for: indexPath)
        
        let cellWidth = (collectionView.frame.width - 24) / 7
        let cellHeight = cellWidth
        
        let cellWidthConstraint = cell.widthAnchor.constraint(equalToConstant: cellWidth)
        let cellHeightConstraint = cell.heightAnchor.constraint(equalToConstant: cellHeight)
        
        cellWidthConstraint.priority = .defaultHigh
        cellHeightConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            cellWidthConstraint,
            cellHeightConstraint
        ])
        
        if indexPath.item < Plan.shared.day {
            cell.backgroundColor = UIColor.systemGreen
        } else {
            cell.backgroundColor = UIColor.systemGray
        }
        
        cell.layer.cornerRadius = 8
        
        return cell
    }
}






