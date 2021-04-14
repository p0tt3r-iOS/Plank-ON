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
    @IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: Property
    let center = UNUserNotificationCenter.current()
    
    let days: [Int] = {
        var days: [Int] = []
        for i in 1...28 {
            days.append(i)
        }
        
        return days
    }()
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Plan.shared.grade

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PlanCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PlanCollectionViewCell.identifier)
        
        setUI()
    }
    
    // MARK: IBAction
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if alarmSwitch.isOn {
            Plan.shared.timeForAlarm = alarmDatePicker.date
            requestSendNotification(time: alarmDatePicker.date)
        } else {
            Plan.shared.timeForAlarm = nil
        }
        
        Plan.shared.isPlankOn = true

        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func alarmSwitchPressed(_ sender: UISwitch) {
        if alarmSwitch.isOn {
            requestAuthNotification()
            alarmDatePicker.isEnabled = true
            alarmLabel.textColor = .label
        } else {
            alarmDatePicker.isEnabled = false
            alarmLabel.textColor = .secondaryLabel
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
        center.requestAuthorization(options: notificationAuthOptions) { success, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func requestSendNotification(time: Date) {
        // Configure Notification Content
        let content = UNMutableNotificationContent()
        content.title = "Let's Plank On!"
        content.body = "플랭크 할 시간입니다!"
        
        // Set Notification Time
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmm"
        
        let hourString = dateFormatter.string(from: time).substring(toIndex: 2)
        let minuteString = dateFormatter.string(from: time).substring(fromIndex: 2)
        
        guard let hour = Int(hourString), let minute = Int(minuteString) else { return }
        
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content,
                                            trigger: trigger)
        
        // Schedule the request with the system.
        center.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlanCollectionViewCell.identifier, for: indexPath) as! PlanCollectionViewCell
        
        let cellWidthConstraint = cell.widthAnchor.constraint(equalToConstant: (collectionView.frame.width - 108) / 7)
        
        cellWidthConstraint.priority = .defaultHigh
        cellWidthConstraint.isActive = true
        
        cell.dayLabel.text = String(days[indexPath.row])
        cell.secTextField.isHidden = true
        cell.secLabel.text = String((Plan.shared.secForDays?[indexPath.row])!)
        
        return cell
    }
}
