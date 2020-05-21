//
//  ViewController.swift
//  iOS_study_assignment01
//
//  Created by 최인정 on 2020/05/21.
//  Copyright © 2020 indoni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval = 1.0
    let count = 0
    var alarmTime: String?
    
    
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var pickerTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        
        
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        pickerTime.text = "선택시간 : "+formatter.string(from: datePickerView.date)
        
        formatter.dateFormat = "hh:mm aaa"
        alarmTime = formatter.string(from: datePickerView.date)
        
    }
    
    @objc func updateTime(){
        let date = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        currentTime.text = "현재시간 : "+formatter.string(from: date as Date)
        
        formatter.dateFormat = "hh:mm aaa"
        let currTime = formatter.string(from: date as Date)
        
        
        if (alarmTime == currTime){
            view.backgroundColor = UIColor.red
        } else {
            view.backgroundColor = UIColor.white
        }
    
    }
    
   
}

