//
//  ViewController.swift
//  UtilExtension
//
//  Created by 侯猛 on 07/26/2022.
//  Copyright (c) 2022 侯猛. All rights reserved.
//

import UIKit
import UtilExtension

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        print("modelName -> \(UIDevice.util.modelName)")
        
        let textView = UITextView(frame: .init(x: 10, y: 100, width: UIScreen.util.width - 20, height: 50))
        textView.delegate = self
//        view.addSubview(textView)

        let attributedString = NSMutableAttributedString(string: "123")
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.red
        shadow.shadowOffset = .init(width: 5, height: 5)
        attributedString.util.addAttribute(
            [
                .font(.systemFont(ofSize: 50)),
                .foregroundColor(.red),
                .link("https://www.baidu.com")
            ]
        )
        textView.attributedText = attributedString
        
        
        let tx = UIImage(named: "tx")
        let mg = UIImage(named: "mg")
        let surge = UIImage(named: "Surge")
        let xcode = UIImage(named: "Xcode")

        let actionModel = UtilButtonActionModel(
            target: self,
            action: #selector(changedSelectedStatus(_:)),
            event: .touchUpInside
        )
        let button = UIButton.util.createGeneralType(
            frame: .init(x: 20, y: 90, width: 200, height: 100),
//            normalTitle: "一一一一",
            titleFont: .systemFont(ofSize: 20),
            titleNormalColor: .black,
            normalImage: xcode?.util.changeSize(to: .init(width: 80, height: 80))
        )
        button.util.insideLayoutType(style: .onlyImageBestRight, spacing: 50)
        view.addSubview(button)
        view.util.addOuterBorderLayer(frame: button.frame, borderWidth: 1, borderColor: .red)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    private func changedSelectedStatus(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc
    private func changedDisableStatus() {
        guard let button = self.view.viewWithTag(10011) as? UIButton else { return }
        button.isSelected = !button.isSelected
    }
    
    @objc
    private func changedDisable1Status() {
        guard let button = self.view.viewWithTag(10011) as? UIButton else { return }
//        button.isSelected = !button.isSelected
        button.isEnabled = !button.isEnabled
    }
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print(URL)
        return true
    }
}
