//
//  ProportionViewController.swift
//  MyShare
//
//  Created by robert ordiz on 4/17/23.
//

import Foundation
import UIKit

class ProportionViewController: BaseViewController {
    private lazy var doneButton:UIButton = {
        let doneButton = UIButton(type: .custom)
        doneButton.setImage(UIImage(named: "checkMark"), for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.layer.cornerRadius = 20
        doneButton.backgroundColor = #colorLiteral(red: 0.2906035781, green: 0.03874258697, blue: 0.4652764797, alpha: 1)
        doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        return doneButton
    }()
    
    lazy var topLabel:UILabel = {
        let topLabel = UILabel()
        topLabel.text = LabelType.totalGroup.rawValue
        topLabel.textAlignment = .center
        topLabel.textColor = .white
        topLabel.font = UIFont.systemFont(ofSize: 22)
        topLabel.adjustsFontSizeToFitWidth = true
        return topLabel
    }()
    
    private lazy var inputValuesTextField:UITextField = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton,doneButton], animated: false)
        
        let inputValuesTextField = UITextField()
        inputValuesTextField.inputAccessoryView = toolbar
        inputValuesTextField.borderStyle = .line
        inputValuesTextField.text = "3"
        inputValuesTextField.keyboardType = .numberPad
        inputValuesTextField.textAlignment = .center
        inputValuesTextField.font = UIFont.systemFont(ofSize: 42)
        inputValuesTextField.textColor = .white
        inputValuesTextField.layer.borderColor = UIColor.darkGray.cgColor
        inputValuesTextField.layer.borderWidth = 1
        inputValuesTextField.layer.cornerRadius = 5
        inputValuesTextField.layer.masksToBounds = true
        inputValuesTextField.setLeftPaddingPoints(5)
        inputValuesTextField.setRightPaddingPoints(5)
        return inputValuesTextField
    }()
    
    override var shouldShowBackButton: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupViews() {
        let homeBtn = UIButton(type: .custom)
        homeBtn.setImage(UIImage(named: "homeBtn"), for: .normal)
        homeBtn.backgroundColor = .clear
        homeBtn.addTarget(self, action: #selector(homeAction), for: .touchUpInside)
        
        view.addSubview(homeBtn)
        homeBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        homeBtn.centerX(inView: view)
        homeBtn.setDimensions(height: 25, width: 25)
        
        let logoImage = UIImageView()
        logoImage.contentMode = .scaleAspectFit
        logoImage.image = UIImage(named: "darkNumOfPeople")
        
        view.addSubview(logoImage)
        logoImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 80)
        logoImage.centerX(inView: view)
        logoImage.setDimensions(height: 55, width: 55)
        
        view.addSubview(topLabel)
        topLabel.anchor(top: logoImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, height: 30)
        
        view.addSubview(inputValuesTextField)
        inputValuesTextField.centerX(inView: view)
        inputValuesTextField.anchor(top: topLabel.bottomAnchor, paddingTop: 15, width: 150, height: 70)
        
        let plusBtn = UIButton(type: .custom)
        plusBtn.setImage(UIImage(named: "plusBtn"), for: .normal)
        plusBtn.backgroundColor = .clear
        plusBtn.tag = 1
        plusBtn.addTarget(self, action: #selector(plusMinusAction), for: .touchUpInside)
        
        view.addSubview(plusBtn)
        plusBtn.anchor(top: inputValuesTextField.topAnchor, left: inputValuesTextField.rightAnchor, paddingLeft: 5, width: 40, height: 35)
        
        let minusBtn = UIButton(type: .custom)
        minusBtn.setImage(UIImage(named: "minusBtn"), for: .normal)
        minusBtn.backgroundColor = .clear
        minusBtn.tag = 2
        minusBtn.addTarget(self, action: #selector(plusMinusAction), for: .touchUpInside)
        
        view.addSubview(minusBtn)
        minusBtn.anchor(left: inputValuesTextField.rightAnchor, bottom: inputValuesTextField.bottomAnchor, paddingLeft: 5, width: 40, height: 35)
        
        view.addSubview(doneButton)
        doneButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 300)
        doneButton.centerX(inView: view)
        doneButton.setDimensions(height: 40, width: 40)
    }
    
    @objc func plusMinusAction(sender: UIButton) {
        var value: Int! = Int(inputValuesTextField.text!)
        if sender.tag > 1 {
            if inputValuesTextField.text != "0" {
                value -= 1
                inputValuesTextField.text = "\(value ?? 0)"
            }
            
            return
        }
        
        value += 1
        inputValuesTextField.text = "\(value ?? 0)"
    }
    
    @objc func homeAction() {
        popToRootViewController()
    }
    
    @objc func doneAction() {
        if inputValuesTextField.text!.count > 0 && inputValuesTextField.text?.isInt == true {
            self.done()
            let viewController = SubTotalViewController()
            viewController.totalGroup = Int(inputValuesTextField.text!)!
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @objc func done() {
        view.endEditing(true)
    }
}
