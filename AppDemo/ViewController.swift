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
import Result

class ViewController: UIViewController {
    
    var sig: Signal<Date,NoError>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let (signal,dispose) = QueueScheduler.signal(interval: DispatchTimeInterval.seconds(1))
        signal.observeValues { (date) in
            print(date)
        }
        
        let producer = SignalProducer<Int, NoError> { observer, disposable in
            observer.send(value: 1)
            observer.send(value: 2)
        }
    
        let keyboardSignal = NotificationCenter.default.reactive.signal(forNotification: Notification.Name.UIKeyboardWillShow)
        
        
    }

}

