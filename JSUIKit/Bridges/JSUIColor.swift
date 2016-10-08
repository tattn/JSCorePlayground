//
//  This was auto-generated by make_bridge.rb
//
//  Created by 田中 達也 on 2016/10/09.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit
import JavaScriptCore

@objc protocol JSUIColor: JSExport {
    static func colorWithWhite(_ white: CGFloat, alpha: CGFloat) -> UIColor
    static func colorWithHue(_ hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> UIColor
    static func colorWithRed(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor
    static func colorWithDisplayP3Red(_ displayP3Red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor
    static func colorWithCGColor(_ cgColor: CGColor) -> UIColor
    static func colorWithPatternImage(_ image: UIImage) -> UIColor
    static func colorWithCIColor(_ ciColor: CIColor) -> UIColor
    func initWithWhite(_ white: CGFloat, alpha: CGFloat) -> UIColor
    func initWithHue(_ hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> UIColor
    func initWithRed(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor
    func initWithDisplayP3Red(_ displayP3Red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor
    func initWithCGColor(_ cgColor: CGColor) -> UIColor
    func initWithPatternImage(_ image: UIImage) -> UIColor
    func initWithCIColor(_ ciColor: CIColor) -> UIColor
    func set()
    func setFill()
    func setStroke()
    func getWhite(_ white: UnsafeMutablePointer<CGFloat>?, alpha: UnsafeMutablePointer<CGFloat>?) -> Bool
    func getHue(_ hue: UnsafeMutablePointer<CGFloat>?, saturation: UnsafeMutablePointer<CGFloat>?, brightness: UnsafeMutablePointer<CGFloat>?, alpha: UnsafeMutablePointer<CGFloat>?) -> Bool
    func getRed(_ red: UnsafeMutablePointer<CGFloat>?, green: UnsafeMutablePointer<CGFloat>?, blue: UnsafeMutablePointer<CGFloat>?, alpha: UnsafeMutablePointer<CGFloat>?) -> Bool
    func colorWithAlphaComponent(_ alpha: CGFloat) -> UIColor
    func initWithColor(_ color: UIColor) -> UIColor
    static var blackColor: UIColor { get }
    static var darkGrayColor: UIColor { get }
    static var lightGrayColor: UIColor { get }
    static var whiteColor: UIColor { get }
    static var grayColor: UIColor { get }
    static var redColor: UIColor { get }
    static var greenColor: UIColor { get }
    static var blueColor: UIColor { get }
    static var cyanColor: UIColor { get }
    static var yellowColor: UIColor { get }
    static var magentaColor: UIColor { get }
    static var orangeColor: UIColor { get }
    static var purpleColor: UIColor { get }
    static var brownColor: UIColor { get }
    static var clearColor: UIColor { get }
    var CGColor: CGColor { get }
    var CIColor: CIColor { get }
    static func new() -> UIView
}

extension JSUIColor where Self: UIColor {
    static func new() -> Self {
        return self.init()
    }
}
