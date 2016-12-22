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
    
    func signal(forNotification name: NSNotification.Name, object: Any? = nil) -> (signal: Signal<Notification, NoError>,dispose: Disposable) {
        let (signal, observer) = Signal<Notification, NoError>.pipe()
        let receiverObject = NotificationReceiver(identifier: name.rawValue, observer: observer)
        NotificationCenter.default.addObserver(receiverObject, selector: #selector(receiverObject.receive(notification:)), name: name, object: object)
        return (signal,receiverObject)
    }
    
}

class SelectorTarget<Value, Error: Swift.Error>: NSObject {
    
    var identifier: AnyHashable
    var observer: Observer<Value, Error>
    
    init(identifier: AnyHashable, observer: Observer<Value, Error>) {
        self.identifier = identifier
        self.observer = observer
        super.init()
    }

}

fileprivate class NotificationReceiver: SelectorTarget<Notification, NoError>,Disposable {
    
    init(identifier: String, observer: Observer<Notification, NoError>) {
        super.init(identifier: identifier, observer: observer)
        NotificationReceiverQueue.shared.add(receiver: self)
    }
    
    private var disposable = false
    var isDisposed: Bool  {
        return disposable
    }
    
    func receive(notification: Notification) {
        observer.send(value: notification)
    }
    
    func dispose() {
        disposable = true
        NotificationCenter.default.removeObserver(self)
        observer.sendCompleted()
        NotificationReceiverQueue.shared.remove(receiver: self)
    }
    
    static func ==(lhs: NotificationReceiver, rhs: NotificationReceiver) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

fileprivate class NotificationReceiverQueue {
    
    static let shared = NotificationReceiverQueue()
    
    private init() {
        
    }
    
    fileprivate var receivers = Set<NotificationReceiver>()
    
    func add(receiver: NotificationReceiver) {
        receivers.insert(receiver)
    }
    
    func remove(receiver: NotificationReceiver) {
        receivers.remove(receiver)
    }
}
