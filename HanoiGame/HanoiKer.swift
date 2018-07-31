//
//  HanoiKer.swift
//  HanoiTest
//
//  Created by mat on 2018/07/22.
//  Copyright © 2018 mat. All rights reserved.
//

import UIKit

enum Places:Int{
    case Left = 0, Middle, Right
    init?(n:Int){
        switch n {
        case Places.Left.rawValue:
            self = .Left
        case Places.Middle.rawValue:
            self = .Middle
        case Places.Right.rawValue:
            self = .Right
        default:
            return nil
        }
    }
}

class HanoiKer: NSObject {
    var selectedDisc:Places? = nil
    var discmax = 15
    var hanoi = Array<Places>()
    init(size:Int){
        for _ in 0..<size{
            hanoi += [.Left]
        }
    }
    func move(from: Places, to: Places)->Int{
        if ismovable(from: from, to: to) == false{
            return -1
        }
        for i in 0..<hanoi.count{
            if hanoi[i] == from{
                hanoi[i] = to
                break
            }
        }
        return 0
    }
    func iscleared()->Bool{
        for h in hanoi{
            if h != .Right{
                return false
            }
        }
        return true
    }
    func ismovable(from: Places, to: Places)->Bool{
        var fromax = 0, tomax = 0
        while(fromax < hanoi.count){
            if hanoi[fromax] == from{
                break
            }
            fromax += 1
        }
        while(tomax < hanoi.count){
            if hanoi[tomax] == to{
                break
            }
            tomax += 1
        }
        if fromax < tomax{
            return true
        }else{
            return false
        }
    }
}
