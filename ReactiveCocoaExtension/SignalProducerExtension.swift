//
//  SignalProducerExtension.swift
//  AppDemo
//
//  Created by 卓同学 on 2016/12/21.
//  Copyright © 2016年 卓同学. All rights reserved.
//

import Foundation
import ReactiveSwift

public extension SignalProducer {
    
    @discardableResult
    public func startWithValue(_ value: @escaping (Value) -> Void) -> Disposable {
        return start(
            Observer(
                value: { value($0) }
            )
        )
    }

}
