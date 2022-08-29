//
//  ViewController.swift
//  UtilExtension_Example_macOS
//
//  Created by 侯猛 on 2022/7/26.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Cocoa
import UtilExtension

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var date = Date()
        print(date)
        date.util_year = 2021
        print(date)
        
        print(UtilDevice.util.modelName)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

