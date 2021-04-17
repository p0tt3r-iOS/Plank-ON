//
//  Constant.swift
//  Plank ON
//
//  Created by 하동훈 on 2021/04/15.
//

import Foundation

struct Constant {
    static var shared = Constant()
    private init() {}
    
    let planForGrade: [[Int]] = [
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
    
    let choices: [Choice] = [Choice(imageName: "Beginner", grade: "초급"),
                            Choice(imageName: "Intermediate", grade: "중급"),
                            Choice(imageName: "Advanced", grade: "상급"),
                            Choice(imageName: "Custom", grade: "커스텀")]
    
    let planData = "PlanData"
}
