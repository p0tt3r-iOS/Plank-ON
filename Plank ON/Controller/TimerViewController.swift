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
    var sec = Plan.shared.plan![Int(Plan.shared.day)]
    var timerString = "00:00"
    var timer = Timer()
    var isTimerOn: Bool = false {
        didSet {
            if isTimerOn {
                startButton.isEnabled = false
            } else {
                startButton.isEnabled = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        if !isTimerOn {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
        }
        isTimerOn = true
    }
    
    func setUI() {
        setTimerLabel()
    }
    
    func setTimerLabel() {
        if sec >= 60 {
            if sec >= 600 {
                timerString = "\(sec / 60):\(sec % 60)"
            } else {
                if sec % 60 < 10 {
                    timerString = "0\(sec / 60):0\(sec % 60)"
                } else {
                    timerString = "0\(sec / 60):\(sec % 60)"
                }
            }
        } else if sec >= 10 {
            timerString = "00:\(sec)"
        } else {
            timerString = "00:0\(sec)"
        }
        
        timerLabel.text = timerString
    }
    
    @objc func updateTimerLabel() {
        setTimerLabel()
        
        if sec == 0 {
            timer.invalidate()
            isTimerOn = false
            Plan.shared.day += 1
        }
        
        sec -= 1
    }
}
