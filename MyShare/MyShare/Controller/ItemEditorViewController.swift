//
//  ItemEditor.swift
//  MyShare
//
//  Created by robert ordiz on 4/20/23.
//

import Foundation
import UIKit

protocol ItemEditorViewControllerDelegate: AnyObject {
    func didUpdate(sender: ItemEditorViewController, index: IndexPath, updatedValue: Items)
}

class ItemEditorViewController: BaseViewController, UIGestureRecognizerDelegate {
    weak var itemEditorViewControllerDelegate: ItemEditorViewControllerDelegate?
    
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
        inputValuesTextField.font = UIFont.systemFont(ofSize: 22)
        inputValuesTextField.textColor = .black
        inputValuesTextField.layer.borderColor = UIColor.darkGray.cgColor
        inputValuesTextField.layer.borderWidth = 1
        inputValuesTextField.layer.cornerRadius = 5
        inputValuesTextField.layer.masksToBounds = true
        inputValuesTextField.setLeftPaddingPoints(3)
        inputValuesTextField.setRightPaddingPoints(3)
        return inputValuesTextField
    }()
    
    private lazy var inputValuesTextField2:UITextField = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton,doneButton], animated: false)
        
        let inputValuesTextField = UITextField()
        inputValuesTextField.inputAccessoryView = toolbar
        inputValuesTextField.borderStyle = .line
        //inputValuesTextField.delegate = self
        inputValuesTextField.keyboardType = .default
        inputValuesTextField.textAlignment = .center
        inputValuesTextField.font = UIFont.systemFont(ofSize: 22)
        inputValuesTextField.textColor = .black
        inputValuesTextField.layer.borderColor = UIColor.darkGray.cgColor
        inputValuesTextField.layer.borderWidth = 1
        inputValuesTextField.layer.cornerRadius = 5
        inputValuesTextField.layer.masksToBounds = true
        inputValuesTextField.setLeftPaddingPoints(3)
        inputValuesTextField.setRightPaddingPoints(3)
        return inputValuesTextField
    }()
    
    var totalDifference: Double! = 0.0
    var index: IndexPath! = nil
    var tag: Int! = 0
    var data: Items! = nil {
        didSet {
            inputValuesTextField2.text = data.item
            inputValuesTextField.text = "$\(data.price ?? 0.0)"
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
        containerView.setDimensions(height: 200, width: 300)
        
        containerView.addSubview(inputValuesTextField)
        inputValuesTextField.anchor(left: containerView.leftAnchor, right: containerView.rightAnchor, paddingLeft: 20, paddingRight: 20, height: 32)
        inputValuesTextField.center(inView: containerView)
        
        let topLabel = UILabel()
        topLabel.textAlignment = .center
        topLabel.textColor = .black
        topLabel.text = "Update Item"
        topLabel.font = UIFont.systemFont(ofSize: 18)
        topLabel.adjustsFontSizeToFitWidth = true
        
        containerView.addSubview(topLabel)
        topLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, height: 20)
        
        containerView.addSubview(inputValuesTextField2)
        inputValuesTextField2.anchor(top: topLabel.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingRight: 20, height: 32)
        
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
    
    @objc func handleBtnAction() {
        data.item = inputValuesTextField2.text
        data.price = Double((inputValuesTextField.text?.dropFirst())!)
        itemEditorViewControllerDelegate?.didUpdate(sender: self, index: index, updatedValue: data)
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
