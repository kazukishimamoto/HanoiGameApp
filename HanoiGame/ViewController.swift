//
//  ViewController.swift
//  HanoiGame
//
//  Created by shima on 2018/07/24.
//  Copyright © 2018年 shima. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var discsSettingPicker: UIPickerView!
    let settingArray : [Int] = [3, 4, 5, 6, 7]
    var selectDiscsNumber :Int = 3
    
    // 設定値を覚えるキーを設定
    let settingKey = "timer_value"
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settingArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(settingArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectDiscsNumber = settingArray[row]
    }
    
    // ゲーム画面終了時の関数
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Pickerの選択を合わせる
        // UserDefaultsの取得
        let setting = UserDefaults.standard
        let timerValue = setting.integer(forKey: settingKey)
        
        for row in 0..<settingArray.count {
            if settingArray[row] == timerValue {
                discsSettingPicker.selectRow(row, inComponent: 0, animated: true)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

