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

        if let entity = entity {
            let planData = NSManagedObject(entity: entity, insertInto: context)
            planData.setValue(choice?.grade, forKey: "grade")
            planData.setValue(Int16(day), forKey: "day")
            planData.setValue(isSet, forKey: "isSet")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchPlan() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let planData = try context.fetch(PlanData.fetchRequest()) as! [PlanData]
            planData.forEach {
                print($0.grade)
            }
            if planData.count > 0 {
                if planData[0].isSet {
                    Plan.shared.isSet = planData[0].isSet
                    Plan.shared.day = planData[0].day
                    Plan.shared.choice?.grade = planData[0].grade!
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}




