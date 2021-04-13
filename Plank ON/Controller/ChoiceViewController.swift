//
//  ChoiceViewController.swift
//  Plank ON
//
//  Created by 하동훈 on 2021/03/11.
//

import UIKit

class ChoiceViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let choices = [
        Choice(imageName: "Beginner", grade: "초급"),
        Choice(imageName: "Intermediate", grade: "중급"),
        Choice(imageName: "Advanced", grade: "상급"),
        Choice(imageName: "Custom", grade: "커스텀")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
        tableView.register(UINib(nibName: "ChoiceCell", bundle: nil), forCellReuseIdentifier: "ChoiceCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "New Plank"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
        
        if self.isMovingFromParent {
            //
        }
    }
}

// MARK: - UITableView DataSource, Delegate

extension ChoiceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceCell", for: indexPath) as! ChoiceCell
        
        cell.gradeImageView.image = UIImage(named: choices[indexPath.row].imageName)
        cell.gradeLabel.text = choices[indexPath.row].grade
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! ChoiceCell
        Plan.shared.grade = cell.gradeLabel.text
        
        self.performSegue(withIdentifier: "ChoiceToSet", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 5
    }
}

