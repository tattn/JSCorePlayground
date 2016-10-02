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

        class_addProtocol(UIView.self, JSUIView.self)
        self.setObject(UIView.self, forKeyedSubscript: "UIView" as NSString)

        class_addProtocol(UIColor.self, JSUIColor.self)
        self.setObject(UIColor.self, forKeyedSubscript: "UIColor" as NSString)
    }

    override init(virtualMachine: JSVirtualMachine!) {
        super.init(virtualMachine:virtualMachine)
    }

    open func setObject(obj: Any, name: String) {
        self.setObject(obj, forKeyedSubscript: name as NSString)
    }
}
