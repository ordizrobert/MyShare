//
//  EvenlyComputationView.swift
//  MyShare
//
//  Created by robert ordiz on 4/17/23.
//

import UIKit
import Foundation

protocol EvenlyComputationViewDelegate: AnyObject {
    func didTapBtn(sender: EvenlyComputationView, btn: UIButton)
}

class EvenlyComputationView: UIView {
    weak var evenlyComputationViewDelegate: EvenlyComputationViewDelegate?
    private lazy var moneybtn:UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 1
        button.setImage(UIImage(named: "pinkMoney"), for: .normal)
        button.addTarget(self, action: #selector(handleBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var groupBtn:UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 2
        button.setImage(UIImage(named: "pinkNumberOfPeople"), for: .normal)
        button.addTarget(self, action: #selector(handleBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var resetBtn:UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 0
        button.setImage(UIImage(named: "resetBtn"), for: .normal)
        button.addTarget(self, action: #selector(resetAction), for: .touchUpInside)
        return button
    }()
    
    lazy var numOfGroupsLabel:UILabel = {
        let numOfGroupsLabel = UILabel()
        numOfGroupsLabel.text = ""
        numOfGroupsLabel.textAlignment = .center
        numOfGroupsLabel.font = UIFont.systemFont(ofSize: 13)
        numOfGroupsLabel.adjustsFontSizeToFitWidth = true
        return numOfGroupsLabel
    }()
    
    lazy var totalBillLabel:UILabel = {
        let totalBillLabel = UILabel()
        totalBillLabel.text = "$-"
        totalBillLabel.textAlignment = .center
        totalBillLabel.font = UIFont.systemFont(ofSize: 13)
        totalBillLabel.adjustsFontSizeToFitWidth = true
        return totalBillLabel
    }()
    
    lazy var topLabel:UILabel = {
        let topLabel = UILabel()
        topLabel.text = LabelType.grandTotal.rawValue
        topLabel.textAlignment = .center
        topLabel.textColor = .white
        topLabel.font = UIFont.systemFont(ofSize: 22)
        topLabel.adjustsFontSizeToFitWidth = true
        return topLabel
    }()
    
    lazy var bottomLabel:UILabel = {
        let bottomLabel = UILabel()
        bottomLabel.text = LabelType.perPerson.rawValue
        bottomLabel.textAlignment = .center
        bottomLabel.textColor = .white
        bottomLabel.font = UIFont.systemFont(ofSize: 22)
        bottomLabel.adjustsFontSizeToFitWidth = true
        return bottomLabel
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
        inputValuesTextField.delegate = self
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
    
    @objc func done() {
        self.endEditing(true)
    }
    
    @objc func resetAction() {
        inputValuesTextField.isEnabled = true
        topLabel.isHidden = false
        topLabel.text = LabelType.grandTotal.rawValue
        inputValuesTextField.text = ""
        numOfGroupsLabel.text = "-"
        totalBillLabel.text = "$-"
        resetBtn.isHidden = true
        bottomLabel.isHidden = true
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        if topLabel.text == LabelType.grandTotal.rawValue {
            let replaced = textField.text!.replacingOccurrences(of: "$", with: "")
            print(replaced)
            let share: Double = Double(replaced) ?? 0.00
            let twoDecimalPlaces = String(format: "%.2f", share)
//            totalBillLabel.text = "$\(textField.text?.dropFirst() ?? "")"
            totalBillLabel.text = "$\(twoDecimalPlaces)"
            if textField.text!.count == 1 {
                inputValuesTextField.text = "$\(checkDollarSign(text: textField.text!))"
            }
        } else {
            numOfGroupsLabel.text = textField.text
        }
    }
    
    @objc func handleBtnAction(sender: UIButton) {
        inputValuesTextField.isEnabled = true
        //inputValuesTextField.text = ""
        topLabel.isHidden = false
        resetBtn.isHidden = true
        bottomLabel.isHidden = true
        if sender.tag > 1 {
            topLabel.text = LabelType.totalGroup.rawValue
            if numOfGroupsLabel.text!.isNumber  {
                inputValuesTextField.text = numOfGroupsLabel.text
            }
        } else {
            let total: String = "\(totalBillLabel.text?.dropFirst() ?? "")"
            topLabel.text = LabelType.grandTotal.rawValue
            //if total.isNumber {
                let share: Double = Double(total)!
                let twoDecimalPlaces = String(format: "$%.2f", share)
                //inputValuesTextField.text = totalBillLabel.text
                inputValuesTextField.text = twoDecimalPlaces
            //}
        }
    }
    
    func checkDollarSign(text: String) -> String {
        let character: Character = "$"
        if text.contains(character) {
            return ""
        }
        
        return text
    }
    
    func setupViews() {
        addSubview(resetBtn)
        resetBtn.anchor(top: topAnchor)
        resetBtn.centerX(inView: self)
        resetBtn.setDimensions(height: 30, width: 30)
        resetBtn.isHidden = true
        
        addSubview(topLabel)
        topLabel.anchor(top: resetBtn.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, height: 30)
        
        addSubview(inputValuesTextField)
        inputValuesTextField.anchor(top: topLabel.bottomAnchor, left: topLabel.leftAnchor, right: topLabel.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingRight: 20, height: 70)
        
        addSubview(bottomLabel)
        bottomLabel.anchor(top: inputValuesTextField.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 5, height: 30)
        bottomLabel.isHidden = true
        
        addSubview(moneybtn)
        moneybtn.anchor(bottom: bottomAnchor, right: centerXAnchor, paddingBottom: 30, paddingRight: 20)
        moneybtn.setDimensions(height: 60, width: 80)
        
        addSubview(totalBillLabel)
        totalBillLabel.anchor(top: moneybtn.bottomAnchor, left: moneybtn.leftAnchor, right: moneybtn.rightAnchor, paddingBottom: 5, height: 18)
        
        addSubview(groupBtn)
        groupBtn.anchor(left: centerXAnchor, bottom: bottomAnchor, paddingLeft: 20, paddingBottom: 30)
        groupBtn.setDimensions(height: 60, width: 80)
        
        addSubview(numOfGroupsLabel)
        numOfGroupsLabel.anchor(top: groupBtn.bottomAnchor, left: groupBtn.leftAnchor, right: groupBtn.rightAnchor, paddingBottom: 5, height: 18)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
}

extension EvenlyComputationView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let total: String = "\(totalBillLabel.text?.dropFirst() ?? "")"
        if totalBillLabel.text!.count > 1 && numOfGroupsLabel.text!.count > 0 {
            inputValuesTextField.isEnabled = false
            topLabel.isHidden = true
            resetBtn.isHidden = false
            bottomLabel.isHidden = false
            let grandTotal: Double = Double(total)!
            let totalGroup: Double = Double(numOfGroupsLabel.text!)!
            let sharePerPerson: Double = grandTotal / totalGroup
            let twoDecimalPlaces = String(format: "%.2f", sharePerPerson)
            inputValuesTextField.text = "$\(twoDecimalPlaces)"
        } else {
            if topLabel.text == LabelType.grandTotal.rawValue {
                topLabel.text = LabelType.totalGroup.rawValue
                if numOfGroupsLabel.text!.isNumber  {
                    inputValuesTextField.text = numOfGroupsLabel.text
                } else {
                    inputValuesTextField.text = ""
                }
            } else {
//                topLabel.text = LabelType.grandTotal.rawValue
//                if total.isNumber {
                    inputValuesTextField.text = totalBillLabel.text
//                } else {
//                    inputValuesTextField.text = ""
//                }
            }
        }
    }
}
