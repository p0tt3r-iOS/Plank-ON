//
//  SettingViewController.swift
//  Plank ON
//
//  Created by 하동훈 on 2021/03/11.
//

import UIKit

class SettingViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var alarmView: UIView!
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!

    // MARK: Property
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    let days = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28]
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Plan.shared.grade

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PlanCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "dayCell")
        
        setUI()
        
        requestAuthNotification()
        requestSendNotification(seconds: 3)
    }
    
    // MARK: IBAction
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if alarmSwitch.isOn {
            Plan.shared.timeForAlarm = alarmDatePicker.date
        } else {
            Plan.shared.timeForAlarm = nil
        }
        
        Plan.shared.isPlankOn = true
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func alarmSwitchPressed(_ sender: UISwitch) {
        if alarmSwitch.isOn {
            
        }
    }
    
    // MARK: Method
    func setUI() {
        alarmView.layer.cornerRadius = 14
        saveButton.layer.cornerRadius = 14
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = UIColor.secondarySystemFill.cgColor
    }
    
    func requestAuthNotification() {
        let notificationAuthOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        userNotificationCenter.requestAuthorization(options: notificationAuthOptions) { success, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func requestSendNotification(seconds: Double) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "알림 제목"
        notificationContent.body = "알림 내용"
        notificationContent.userInfo = ["targetScene" : "splash"]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error = error {
            print("Error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - UICollectionView DataSource & Delegate

extension SettingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! PlanCollectionViewCell
        
        cell.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 12).isActive = true
        
        cell.dayLabel.text = String(days[indexPath.row])
        cell.secTextField.isHidden = true
        cell.secLabel.text = String((Plan.shared.secForDays?[indexPath.row])!)
        
        return cell
    }
}
