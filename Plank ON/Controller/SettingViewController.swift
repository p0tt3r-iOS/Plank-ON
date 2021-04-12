//
//  SettingViewController.swift
//  Plank ON
//
//  Created by 하동훈 on 2021/03/11.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let days = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "PlanCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "dayCell")
    }
    


}

// MARK: - UICollectionView DataSource & Delegate

extension SettingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! PlanCollectionViewCell
        
        cell.dayLabel.text = String(days[indexPath.row])
        
        cell.secTextField.isHidden = true
        
        cell.secLabel.text = String((Plan.shared.secForDays?[indexPath.row])!)
        
        
        return cell
    }
    
    
}
