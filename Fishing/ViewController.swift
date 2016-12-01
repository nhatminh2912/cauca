//
//  ViewController.swift
//  Fishing
//
//  Created by Nhật Minh on 11/29/16.
//  Copyright © 2016 Nhật Minh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var level_label: UILabel!
    
    var gameManager: GameManager?
    
    var fishes = 0
    
    var timer = Timer()
        override func viewDidLoad() {
        
        super.viewDidLoad()
        self.gameManager = GameManager()
        self.view.addSubview((self.gameManager?.hookerView)!)
        self.gameManager?.addFishtoviewController(viewcontroller: self, width: Int(self.view.bounds.width),fishType: 2)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.tapHandle(_:))))
        Timer.scheduledTimer(timeInterval: 0.02, target: self.gameManager!, selector: Selector(("updateMove")), userInfo: nil, repeats: true)
        
       timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(generateFish), userInfo: nil, repeats: true)
        
    }

    func tapHandle(_ sender: UIGestureRecognizer)
    {
        let tapPoint = sender.location(in: self.view)
        self.gameManager?.dropHookerAtX(x: Int(tapPoint.x))
    }
    
    func generateFish()
    {
        fishes += 1
        
        print("\(fishes)")
        
        if fishes == 10
        {
            timer.invalidate()
        }
        
        let random = Int(arc4random_uniform(3))
        
        self.gameManager?.addFishtoviewController(viewcontroller: self, width: Int(self.view.bounds.width), fishType: random)
    }
}

