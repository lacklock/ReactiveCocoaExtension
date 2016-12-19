//
//  ViewController.swift
//  AppDemo
//
//  Created by 卓同学 on 2016/12/19.
//  Copyright © 2016年 卓同学. All rights reserved.
//

import UIKit
import ReactiveCocoaExtension
import ReactiveSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let (signal,dispose) = QueueScheduler.signal(interval: DispatchTimeInterval.seconds(1))
        
        
    }

}

