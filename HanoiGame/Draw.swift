//
//  Draw.swift
//  HanoiTest
//
//  Created by mat on 2018/07/22.
//  Copyright © 2018 mat. All rights reserved.
//

import UIKit

class Draw: UIView {
    var hanoi:HanoiKer
    let paddingx:CGFloat = 50.0, paddingy:CGFloat = 50.0
    let hanoiRect:CGRect
    let hanoiRRect:CGRect, hanoiMRect:CGRect, hanoiLRect:CGRect
    
    init(frame:CGRect, hanoi:HanoiKer){
        self.hanoi = hanoi
        hanoiRect = CGRect(x: paddingx, y: paddingy, width: frame.width - 2.0*paddingx, height: frame.height - 2.0*paddingy)
        hanoiLRect = CGRect(x: hanoiRect.minX, y: hanoiRect.minY, width: hanoiRect.width/3.0, height: hanoiRect.height)
        hanoiMRect = CGRect(x: hanoiLRect.maxX, y: hanoiLRect.minY, width: hanoiRect.width/3.0, height: hanoiRect.height)
        hanoiRRect = CGRect(x: hanoiMRect.maxX, y: hanoiMRect.minY, width: hanoiRect.width/3.0, height: hanoiRect.height)
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        for h in (hanoi.hanoi){
            print("\(h) ", terminator:"")
        }
        print()
        // Drawing code
        let lefts = conv(hanoi: hanoi.hanoi, p: Places.Left), middles = conv(hanoi:hanoi.hanoi, p:Places.Middle), rights = conv(hanoi:hanoi.hanoi, p:Places.Right)
        var rectL = [UIBezierPath](), rectM = [UIBezierPath](), rectR = [UIBezierPath]()
        var p:CGPoint = CGPoint(x: hanoiLRect.minX, y: hanoiLRect.minY)
        for i in 0..<lefts.count {
            if lefts[i] == 0{
                continue
            }
            let rect = getRect(line: i, size: lefts[i])
            if hanoi.selectedDisc == .Left {
                rectL.append(UIBezierPath(rect: CGRect(x: rect.minX + p.x, y: p.y, width: rect.width, height: rect.height)))
                hanoi.selectedDisc = nil
                continue
            }
            rectL.append(UIBezierPath(rect: CGRect(x: rect.minX + p.x, y: rect.minY + p.y, width: rect.width, height: rect.height)))
        }
        p = CGPoint(x: hanoiMRect.minX, y: hanoiMRect.minY)
        for i in 0..<middles.count{
            if middles[i] == 0{
                continue
            }
            let rect = getRect(line: i, size: middles[i])
            if hanoi.selectedDisc == .Middle {
                rectM.append(UIBezierPath(rect: CGRect(x: rect.minX + p.x, y: p.y, width: rect.width, height: rect.height)))
                hanoi.selectedDisc = nil
                continue
            }
            rectM.append(UIBezierPath(rect: CGRect(x: rect.minX + p.x, y: rect.minY + p.y, width: rect.width, height: rect.height)))
        }
        p = CGPoint(x: hanoiRRect.minX, y: hanoiRRect.minY)
        for i in 0..<rights.count{
            if rights[i] == 0{
                continue
            }
            let rect = getRect(line: i, size: rights[i])
            if hanoi.selectedDisc == .Right {
                rectR.append(UIBezierPath(rect: CGRect(x: rect.minX + p.x, y: p.y, width: rect.width, height: rect.height)))
                hanoi.selectedDisc = nil
                continue
            }
            rectR.append(UIBezierPath(rect: CGRect(x: rect.minX + p.x, y: rect.minY + p.y, width: rect.width, height: rect.height)))
        }
        //draw
        for r in rectL{
            UIColor.blue.setFill()
            r.fill()
            r.stroke()
        }
        for r in rectM{
            UIColor.yellow.setFill()
            r.fill()
            r.stroke()
        }
        for r in rectR{
            UIColor.red.setFill()
            r.fill()
            r.stroke()
        }
    }
    func conv(hanoi:[Places], p:Places) -> [Int]{
        var lines = [Int]()
        var j = 0
        for i in 0..<hanoi.count{
            if hanoi[i] == p{
                lines.append(i + 1)
                j += 1
            }
        }
        while j < self.hanoi.discmax{
            lines.insert(0, at: 0)
            j += 1
        }
        return lines
    }
    // return CGRect of disc in hanoiPRect
    // line: top == 0
    // size: size-th biggest disc
    func getRect(line: Int, size: Int) -> CGRect{
        let w:CGFloat = (2.0*CGFloat(size) - 1.0)*CGFloat(hanoiRect.width/3.0)/(2.0*CGFloat(hanoi.discmax) - 1.0)
        let h:CGFloat = CGFloat(hanoiRect.height)/CGFloat(hanoi.discmax)
        let x:CGFloat = (CGFloat(hanoiRect.width)/3.0 - w)/2.0
        let y:CGFloat = CGFloat(line)*h
        let rect:CGRect = CGRect(x: x, y: y, width: w, height: h)
        return rect
    }
    func getPlace(point:CGPoint) -> Places?{
        let p:Places?
        if point.y < hanoiRect.minY || hanoiRect.maxY < point.y{
            p = nil
        }else if hanoiLRect.minX < point.x && point.x < hanoiLRect.minX + hanoiLRect.width{//left
            p = Places.Left
        }else if hanoiMRect.minX < point.x && point.x < hanoiMRect.minX + hanoiMRect.width{//middle
            p = Places.Middle
        }else if hanoiRRect.minX < point.x && point.x < hanoiRRect.minX + hanoiRRect.width{//right
            p = Places.Right
        }else{
            p = nil
        }
        return p
    }
}














































