//
//  ViewController.swift
//  JSCorePlayground
//
//  Created by 田中 達也 on 2016/10/03.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit
import JavaScriptCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let context: JSContext! = JSContext()
        context.exceptionHandler = { context, exception in
            guard let exception = exception else { return }
            //let stacktrace = exception.objectForKeyedSubscript("stack").toString()

            let line = exception.objectForKeyedSubscript("line")!
            let column = exception.objectForKeyedSubscript("column")!

            print("JS Error(\(line), \(column)): \(exception)")
        }

        class_addProtocol(UIView.self, JSUIView.self)
        context.setObject(UIView.self, forKeyedSubscript: "UIView" as NSString)

        class_addProtocol(UIColor.self, JSUIColor.self)
        context.setObject(UIColor.self, forKeyedSubscript: "UIColor" as NSString)


        context.setObject(view, forKeyedSubscript: "view" as NSString)

        context.evaluateScript(
            "var v = UIView.new();" + "\n" +
            "v.backgroundColor = UIColor.redColor();" + "\n" +
            "v.frame = {x: 20, y: 80, width: 200, height: 80};" + "\n" +
            "view.addSubview(v);"
        )

//        let value = context.objectForKeyedSubscript("window")
    }


}


@objc public protocol JSUIView: JSExport {

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

@objc public protocol JSUIWindow: JSExport {
}

@objc public protocol JSUIColor: JSExport {
    static func redColor() -> UIColor
}
