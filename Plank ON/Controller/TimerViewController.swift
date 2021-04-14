//
//  TimerViewController.swift
//  Plank ON
//
//  Created by 하동훈 on 2021/03/11.
//

import UIKit

class TimerViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    let day = Plan.shared.day
    var sec = Plan.shared.secForDays![Plan.shared.day]
    var timerString = "00:00"
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
        
    }
    
    func setUI() {
        timerLabel.text = "00:\(String(sec))"
    }
    
    @objc func updateTimerLabel() {
        if sec >= 60 {
            timerString = "\(sec / 60):\(sec % 60)"
        } else if sec >= 10 {
            timerString = "00:\(sec)"
        } else {
            timerString = "00:0\(sec)"
        }
        
        timerLabel.text = timerString
        
        if sec == 0 {
            timer.invalidate()
        }
        
        sec -= 1
    }
    

}
