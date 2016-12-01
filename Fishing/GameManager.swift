//
//  GameManager.swift
//  Fishing
//
//  Created by Nhật Minh on 11/29/16.
//  Copyright © 2016 Nhật Minh. All rights reserved.
//

import UIKit

class GameManager: NSObject{
    
    var fishViews: NSMutableArray?
    
    var hookerView: HookerView?
    
    var exp = 0
    
    override init()
    {
        self.fishViews = NSMutableArray()
        self.hookerView = HookerView(frame: CGRect(x: 0, y: -490, width: 20, height: 490))
    }
    
    func addFishtoviewController(viewcontroller: UIViewController, width: Int, fishType: Int)
        // thêm cá
    {
        
        let fishView = FishView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
            
        if fishType == 2
        {
            fishView.generateFish(width: width, imageName: "fish2")
        }
        
        else if fishType == 1
        {
            fishView.generateFish(width: width, imageName: "fish3")
        }
        else
        {
            fishView.generateFish(width: width, imageName: "fish1")
        }
        
        
        self.fishViews?.add(fishView)
        
        viewcontroller.view.addSubview(fishView)
    }
    
    
    func bite(fishView: FishView)
    {
        if (fishView.size == fishView.SMALL && fishView.status != fishView.CAUGHT && self.hookerView?.status == self.hookerView?.DROPPING)
        {
            exp = exp + 1
            fishView.caught()
            fishView.center = CGPoint(x: self.hookerView!.center.x, y: self.hookerView!.frame.origin.y + self.hookerView!.frame.height + fishView.frame.width/2)
            self.hookerView?.status = self.hookerView?.CAUGHTF
        }
        
        if (exp >= 10 && fishView.size == fishView.MEDIUM && fishView.status != fishView.CAUGHT && self.hookerView?.status == self.hookerView?.DROPPING)
        {
            exp = exp + 2
            fishView.caught()
            fishView.center = CGPoint(x: self.hookerView!.center.x, y: self.hookerView!.frame.origin.y + self.hookerView!.frame.height + fishView.frame.width/2)
            self.hookerView?.status = self.hookerView?.CAUGHTF
        }
        
        if ( exp >= 100 && fishView.size == fishView.LARGE && fishView.status != fishView.CAUGHT && self.hookerView?.status == self.hookerView?.DROPPING)
        {
            exp = exp + 10
            fishView.caught()
            fishView.center = CGPoint(x: self.hookerView!.center.x, y: self.hookerView!.frame.origin.y + self.hookerView!.frame.height + fishView.frame.width/2)
            self.hookerView?.status = self.hookerView?.CAUGHTF
        }
    }
    
    
    func updateMove()
    {
        self.hookerView?.updateMove()
        
        for fishView in self.fishViews!
        {
            (fishView as AnyObject).updateMove() // cá di chuyển
            
            if (((fishView as AnyObject).frame).contains(CGPoint(x: self.hookerView!.center.x, y: self.hookerView!.frame.origin.y + self.hookerView!.frame.height + (fishView as AnyObject).frame.width/2)))  // nếu cá cắn câu thì gọi hàm bite()
                
            {
                bite (fishView: fishView as! FishView)
            }
        }
    }
    
    
    func dropHookerAtX(x: Int)
        // thả câu
    {
        self.hookerView?.dropDownAtX(x: x)
    }
    
    
}
