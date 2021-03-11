//
//  ChoiceViewController.swift
//  Plank ON
//
//  Created by 하동훈 on 2021/03/11.
//

import UIKit

class ChoiceViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let selections = SelectionData().selections
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.reloadData()
        
        tableView.register(UINib(nibName: "SelectionCell", bundle: nil), forCellReuseIdentifier: "SelectionCell")
        
    }
}


extension ChoiceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionCell", for: indexPath) as! SelectionCell
        
        cell.gradeImageView.image = UIImage(systemName: selections[indexPath.row].imageName, withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .bold))
        cell.gradeLabel.text = selections[indexPath.row].grade
        
        return cell
    }
}
