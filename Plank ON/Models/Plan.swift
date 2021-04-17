//
//  Plan.swift
//  Plank ON
//
//  Created by 하동훈 on 2021/04/12.
//

import UIKit
import CoreData


struct Plan {
    static var shared = Plan()
    private init() {}
    
    var isSet: Bool = false
    
    var choice: Choice? {
        didSet {
            if choice?.grade == "초급" {
                plan = Constant.shared.planForGrade[0]
            } else {
                plan = Constant.shared.planForGrade[1]
            }
        }
    }
    
    var grade: String?
    var plan: [Int]?
    
    var day: Int16 = 0
    
    func updatePlan() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: Constant.shared.planData, in: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlanData")
        
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 {
                results?[0].setValue(Plan.shared.choice!.grade, forKey: "grade")
                results?[0].setValue(Int16(Plan.shared.day), forKey: "day")
                results?[0].setValue(Plan.shared.isSet, forKey: "isSet")
            } else {
                if let entity = entity {
                    let planData = NSManagedObject(entity: entity, insertInto: context)
                    planData.setValue(Plan.shared.choice!.grade, forKey: "grade")
                    planData.setValue(Int16(Plan.shared.day), forKey: "day")
                    planData.setValue(Plan.shared.isSet, forKey: "isSet")
                }
            }
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchPlan() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let planData = try context.fetch(PlanData.fetchRequest()) as! [PlanData]
            if planData.count != 0 {
                if planData[0].isSet {
                    Plan.shared.isSet = planData[0].isSet
                    Plan.shared.day = planData[0].day
                    
                    switch planData[0].grade {
                    case Constant.shared.choices[0].grade:
                        Plan.shared.choice = Constant.shared.choices[0]
                    case Constant.shared.choices[1].grade:
                        Plan.shared.choice = Constant.shared.choices[1]
                    case Constant.shared.choices[2].grade:
                        Plan.shared.choice = Constant.shared.choices[1]
                    case Constant.shared.choices[3].grade:
                        Plan.shared.choice = Constant.shared.choices[1]
                    // MARK: Has to fix
                    default:
                        Plan.shared.choice = Constant.shared.choices[0]
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}




