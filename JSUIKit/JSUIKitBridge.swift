//
//  JSUIKitBridge.swift
//  JSCorePlayground
//
//  Created by 田中 達也 on 2016/10/03.
//  Copyright © 2016年 tattn. All rights reserved.
//

import Foundation
import JavaScriptCore

@objc protocol JSUIView: JSExport {

    var frame: CGRect { get set }
    var backgroundColor: UIColor { get set }

    static func new() -> UIView

    func addSubview(_ view: UIView)
}

extension JSUIView where Self: UIView {
    static func new() -> Self {
        return self.init()
    }
}

@objc protocol JSUIWindow: JSExport {
}

