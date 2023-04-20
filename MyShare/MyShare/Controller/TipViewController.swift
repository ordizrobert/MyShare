//
//  TipViewController.swift
//  MyShare
//
//  Created by robert ordiz on 4/18/23.
//

import Foundation
import UIKit

class TipViewController: BaseViewController {
    private lazy var doneButton:UIButton = {
        let doneButton = UIButton(type: .custom)
        doneButton.setImage(UIImage(named: "checkMark"), for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.layer.cornerRadius = 20
        doneButton.backgroundColor = #colorLiteral(red: 0.2906035781, green: 0.03874258697, blue: 0.4652764797, alpha: 1)
        doneButton.addTarget(self, action: #selector(donaAction), for: .touchUpInside)
        return doneButton
    }()
    
    lazy var topLabel:UILabel = {
        let topLabel = UILabel()
        topLabel.text = LabelType.tipAmount.rawValue
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
        //inputValuesTextField.delegate = self
        inputValuesTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        inputValuesTextField.keyboardType = .decimalPad
        inputValuesTextField.textAlignment = .center
        inputValuesTextField.font = UIFont.systemFont(ofSize: 42)
        inputValuesTextField.textColor = .white
        inputValuesTextField.layer.borderColor = UIColor.darkGray.cgColor
        inputValuesTextField.layer.borderWidth = 1
        inputValuesTextField.layer.cornerRadius = 5
        inputValuesTextField.layer.masksToBounds = true
        inputValuesTextField.setLeftPaddingPoints(20)
        inputValuesTextField.setRightPaddingPoints(20)
        return inputValuesTextField
    }()
    
    var totalGroup: Int = 0
    var subTotal: Double = 0.0
    var tax: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupViews() {
        let homeButton = UIBarButtonItem(image: UIImage(named: "homeBtn"),  style: .plain, target: self, action: #selector(homeAction))
        navigationItem.rightBarButtonItem = homeButton
        
        let logoImage = UIImageView()
        logoImage.contentMode = .scaleAspectFit
        logoImage.image = UIImage(named: "darkTipIcon")
        
        view.addSubview(logoImage)
        logoImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 80)
        logoImage.centerX(inView: view)
        logoImage.setDimensions(height: 55, width: 55)
        
        view.addSubview(topLabel)
        topLabel.anchor(top: logoImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, height: 30)
        
        view.addSubview(inputValuesTextField)
        inputValuesTextField.anchor(top: topLabel.bottomAnchor, left: topLabel.leftAnchor, right: topLabel.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingRight: 20, height: 70)
        
        view.addSubview(doneButton)
        doneButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 300)
        doneButton.centerX(inView: view)
        doneButton.setDimensions(height: 40, width: 40)
    }
    
    @objc func homeAction() {
        popToRootViewController()
    }
    
    @objc func donaAction() {
        self.done()
        let tip: String = "\(inputValuesTextField.text?.dropFirst() ?? "")"
        if inputValuesTextField.text!.count > 0 && tip.isInt == true {
            let viewController = ProportionDashboardViewController()
            viewController.totalGroup = self.totalGroup
            viewController.subTotal = self.subTotal
            viewController.tax = self.tax
            viewController.tip = Double(tip)!
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        if textField.text!.count == 1 {
            inputValuesTextField.text = "$\(checkDollarSign(text: textField.text!))"
        }
    }
    
    @objc func done() {
        view.endEditing(true)
    }
    
    func checkDollarSign(text: String) -> String {
        let character: Character = "$"
        if text.contains(character) {
            return ""
        }
        
        return text
    }
}
