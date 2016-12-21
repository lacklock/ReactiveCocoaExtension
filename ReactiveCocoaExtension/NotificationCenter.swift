//
//  Notification.swift
//  AppDemo
//
//  Created by 卓同学 on 2016/12/21.
//  Copyright © 2016年 卓同学. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

public extension Reactive where Base: NotificationCenter {
    
    func signal(forNotification name: NSNotification.Name, object: Any? = nil) -> Signal<Notification, NoError> {
        let (signal, observer) = Signal<Notification, NoError>.pipe()
        let object = NotificationObserverObject(identifier: name.rawValue, observer: observer)
        NotificationCenter.default.addObserver(object, selector: #selector(object.receive(notification:)), name: name, object: object)
        return signal
    }
    
}

class ObserverObject<Value, Error: Swift.Error>: NSObject {
    
    var identifier: AnyHashable
    var observer: Observer<Value, Error>
    
    init(identifier: AnyHashable, observer: Observer<Value, Error>) {
        self.identifier = identifier
        self.observer = observer
        super.init()
    }

}

class NotificationObserverObject: ObserverObject<Notification, NoError> {
    
    func receive(notification: Notification) {
        observer.send(value: notification)
    }
}
