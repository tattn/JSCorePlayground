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

        context.setObject(view, name: "view")

        let jsPath = Bundle.main.path(forResource: "sample", ofType: "js")!
        let js = try! String(contentsOfFile: jsPath)
        context.evaluateScript(js)

//        let value = context.objectForKeyedSubscript("view")
    }


}
