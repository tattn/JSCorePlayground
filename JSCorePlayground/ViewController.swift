//
//  ViewController.swift
//  JSCorePlayground
//
//  Created by 田中 達也 on 2016/10/03.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit
import JSUIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let context = JSUIContext()

        context.setObject(view, forKeyedSubscript: "view" as NSString)

        context.evaluateScript(
            "var v = UIView.new();" + "\n" +
            "v.backgroundColor = UIColor.redColor();" + "\n" +
            "v.frame = {x: 20, y: 80, width: 200, height: 80};" + "\n" +
            "view.addSubview(v);"
        )

//        let value = context.objectForKeyedSubscript("view")
    }


}
