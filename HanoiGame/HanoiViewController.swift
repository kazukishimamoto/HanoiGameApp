//
//  HanoiViewController.swift
//  HanoiGame
//
//  Created by shima on 2018/07/25.
//  Copyright © 2018年 shima. All rights reserved.
//

import UIKit

class HanoiViewController: UIViewController, UIGestureRecognizerDelegate{
    
    var hanoiDraw:Draw? = nil
    let hanoi:HanoiKer = HanoiKer(size: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //TapGesture
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(HanoiViewController.tapped(_:)))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        
        //Draw
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        hanoiDraw = Draw(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), hanoi: hanoi)
        self.view.addSubview(hanoiDraw!)
        hanoiDraw!.isOpaque = false
        self.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    var isselected = false
    var from:Places? = nil, to:Places? = nil
    @objc func tapped(_ sender: UITapGestureRecognizer){
        if sender.state == .ended{
            let p = sender.location(in: self.view)
            if isselected == false{
                from = (hanoiDraw!.getPlace(point: p))
                if from != nil{
                    print("tapped frome:\(from)")
                    hanoi.selectedDisc = from
                    isselected = true
                }
            }else{
                to = (hanoiDraw!.getPlace(point: p))
                if to != nil{
                    print("tapped to:\(to)")
                    let v = hanoi.move(from: from!, to: to!)
                    if hanoi.iscleared() {
                        print("クリア")
                        //まずは、同じstororyboard内であることをここで定義します
                        let storyboard: UIStoryboard = self.storyboard!
                        //ここで移動先のstoryboardを選択(今回の場合は先ほどsecondと名付けたのでそれを書きます)
                        let second = storyboard.instantiateViewController(withIdentifier: "clearscreen")
                        //ここが実際に移動するコードとなります
                        self.present(second, animated: true, completion: nil)
                    }
                    print("move:\(v)")
                    hanoi.selectedDisc = nil
                    isselected = false
                }
                for h in (hanoi.hanoi){
                    print("\(h) ", terminator:"")
                }
                print()
            }
            loadView()
            viewDidLoad()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
