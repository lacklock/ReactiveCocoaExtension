//
//  SchedulerExtension.swift
//  AppDemo
//
//  Created by 卓同学 on 2016/12/19.
//  Copyright © 2016年 卓同学. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

public extension QueueScheduler {
    
    /// 根据指定的interval，返回一个Signal和Dispose
    /// 因为使用的是GCDTimer，需要释放资源，所以需要手动控制计时器的释放
    public static func signal(interval: DispatchTimeInterval) -> (Signal<Date,NoError>,() -> Void) {
        let scheduler = QueueScheduler()
        let (signal,observer) = Signal<Date,NoError>.pipe()
        let schedulerDispose = scheduler.schedule(after: Date(), interval: interval) {
            observer.send(value: Date())
        }
        let dispose = {
            observer.sendCompleted()
            schedulerDispose?.dispose()
        }
        return (signal,dispose)
    }
    
}
