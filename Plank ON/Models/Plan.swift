//
//  Plan.swift
//  Plank ON
//
//  Created by 하동훈 on 2021/04/12.
//

import Foundation

struct Plan {
    static var shared = Plan()
    private init() {}
    
    private var planForGrade: [[Int]] = [
        [15, 20, 25, 30, 30, 35, 40,
         45, 50, 50, 55, 60, 60, 65,
         70, 75, 75, 80, 85, 90, 90,
         95, 100, 105, 110, 110, 120, 120],
        [30, 40, 50, 60, 60, 70, 80,
        90, 90, 100, 110, 120, 120, 130,
        140, 150, 160, 160, 170, 180, 190,
        190, 200, 210, 220, 220, 230, 240],
        [120, 130, 140, 150, 150, 160, 170,
        180, 180, 190, 200, 210, 210, 220],
    ]
    
    var grade: String? {
        didSet {
            if grade == "초급" {
                secForDays = planForGrade[0]
            } else {
                secForDays = planForGrade[1]
            }
        }
    }
    
    var secForDays: [Int]?
    
}
