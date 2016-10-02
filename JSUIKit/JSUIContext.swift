//
//  JSUIContext.swift
//  JSCorePlayground
//
//  Created by 田中 達也 on 2016/10/03.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation
import JavaScriptCore

open class JSUIContext: JSContext {

    public override init() {
        super.init()

        self.exceptionHandler = { context, exception in
            guard let exception = exception else { return }
            //let stacktrace = exception.objectForKeyedSubscript("stack").toString()

            let line = exception.objectForKeyedSubscript("line")!
            let column = exception.objectForKeyedSubscript("column")!

            print("JS Error(\(line), \(column)): \(exception)")
        }

        let classes: [AnyClass] = [
            UIView.self,
            UIColor.self,
        ]

        classes.forEach {
            addUIClass(klass: $0)
        }
    }

    override init(virtualMachine: JSVirtualMachine!) {
        super.init(virtualMachine:virtualMachine)
    }

    open func setObject(obj: Any, name: String) {
        self.setObject(obj, forKeyedSubscript: name as NSString)
    }

    private func addUIClass(klass: AnyClass) {
        let className = String(describing: klass)
        class_addProtocol(klass, NSProtocolFromString("JSUIKit.JS\(className)"))
        self.setObject(klass, forKeyedSubscript: className as NSString)
    }
}
