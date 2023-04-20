//
//  ProportionValuesEditor.swift
//  MyShare
//
//  Created by robert ordiz on 4/19/23.
//

import Foundation
import UIKit

protocol ProportionValuesEditorDelegate: AnyObject {
    func didUpdate(sender: ProportionValuesEditor, index: Int, value: String)
}

class ProportionValuesEditor: BaseViewController, UIGestureRecognizerDelegate {
    weak var proportionValuesEditorDelegate: ProportionValuesEditorDelegate?
    
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
        inputValuesTextField.font = UIFont.systemFont(ofSize: 28)
        inputValuesTextField.textColor = .black
        inputValuesTextField.layer.borderColor = UIColor.darkGray.cgColor
        inputValuesTextField.layer.borderWidth = 1
        inputValuesTextField.layer.cornerRadius = 5
        inputValuesTextField.layer.masksToBounds = true
        inputValuesTextField.setLeftPaddingPoints(20)
        inputValuesTextField.setRightPaddingPoints(20)
        return inputValuesTextField
    }()
    
    var tag: Int! = 0
    var value: String = "" {
        didSet {
            inputValuesTextField.text = value
        }
    }
    
    override var isGradient: Bool {
        return false
    }
    
    override func setupViews() {
        view.backgroundColor = .clear
        let containerView = UIView()
        containerView.layer.cornerRadius = 4
        containerView.backgroundColor = .white
        containerView.dropShadow(scale: true)
        view.addSubview(containerView)
        
        containerView.center(inView: view)
        containerView.setDimensions(height: 200, width: 250)
        
        containerView.addSubview(inputValuesTextField)
        inputValuesTextField.anchor(left: containerView.leftAnchor, right: containerView.rightAnchor, paddingLeft: 20, paddingRight: 20, height: 32)
        inputValuesTextField.center(inView: containerView)
        
        let topLabel = UILabel()
        topLabel.text = LabelType.grandTotal.rawValue
        topLabel.textAlignment = .center
        topLabel.textColor = .black
        topLabel.text = updateType()
        topLabel.font = UIFont.systemFont(ofSize: 22)
        topLabel.adjustsFontSizeToFitWidth = true
        
        containerView.addSubview(topLabel)
        topLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 20, height: 30)
        
        let updateBtn = UIButton(type: .system)
        updateBtn.setTitle("Update", for: .normal)
        updateBtn.setTitleColor(.white, for: .normal)
        updateBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        updateBtn.backgroundColor = #colorLiteral(red: 0.630576551, green: 0.3288735151, blue: 0.8758888841, alpha: 1)
        updateBtn.addTarget(self, action: #selector(handleBtnAction), for: .touchUpInside)
        containerView.addSubview(updateBtn)
        
        containerView.addSubview(updateBtn)
        updateBtn.anchor(left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingLeft: 30, paddingBottom: 30, paddingRight: 30, height: 30)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissAction))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    func updateType() -> String {
        if tag == 1 {
            return "Update Subtotal Value"
        } else if tag == 2 {
            return "Update Tip Value"
        } else {
            return "Update Tax Value"
        }
    }
    
    @objc func handleBtnAction() {
        proportionValuesEditorDelegate?.didUpdate(sender: self, index: tag, value: inputValuesTextField.text!)
        self.dismiss(animated: true)
    }
    
    @objc func done() {
        view.endEditing(true)
    }
    
    @objc func dismissAction(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.view
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        if textField.text!.count == 1 {
            inputValuesTextField.text = "$\(checkDollarSign(text: textField.text!))"
        }
    }
    
    func checkDollarSign(text: String) -> String {
        let character: Character = "$"
        if text.contains(character) {
            return ""
        }
        
        return text
    }
}


