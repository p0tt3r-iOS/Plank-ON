//
//  ViewController.swift
//  Plank ON
//
//  Created by 하동훈 on 2021/03/11.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var turnOnButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addBottomBorder(width: 0.5)
        turnOnButton.layer.cornerRadius = turnOnButton.frame.width / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "My Plank"
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
        
        cell.backgroundColor = UIColor.systemGreen
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    
}






