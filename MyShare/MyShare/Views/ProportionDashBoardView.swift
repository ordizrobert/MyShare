//
//  ProportionDashBoardView.swift
//  MyShare
//
//  Created by robert ordiz on 4/18/23.
//

import UIKit
import Foundation

protocol ProportionDashBoardViewDelegate: AnyObject {
    //func didTapBtn(sender: ProportionDashBoardView, btn: UIButton)
    func didChangeValue(sender: ProportionDashBoardView, value: String)
    
    func didChangeTip(sender: ProportionDashBoardView, value: Double)
    
    func didChangeTax(sender: ProportionDashBoardView, value: Double)
    
    func didChangeSubtotal(sender: ProportionDashBoardView, value: Double)
}

class ProportionDashBoardView: UIView {
    weak var proportionDashBoardViewDelegate: ProportionDashBoardViewDelegate?
    private lazy var moneybtn:UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 1
        button.setImage(UIImage(named: "darkMoney"), for: .normal)
        //button.imageView?.contentMode = .scaleAspectFit
        //button.addTarget(self, action: #selector(handleBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var groupBtn:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "darkGroup"), for: .normal)
        //button.addTarget(self, action: #selector(handleBtnAction), for: .touchUpInside)
        return button
    }()

    private lazy var subtotalButton:UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 1
        button.setImage(UIImage(named: "darkSubTotalicon"), for: .normal)
        button.addTarget(self, action: #selector(handleBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var tipButton:UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 2
        button.setImage(UIImage(named: "darkTipIcon"), for: .normal)
        button.addTarget(self, action: #selector(handleBtnAction), for: .touchUpInside)
        return button
    }()
    
//    private lazy var totalButton:UIButton = {
//        let button = UIButton(type: .custom)
//        button.setImage(UIImage(named: "darkSubTotalicon"), for: .normal)
//        button.addTarget(self, action: #selector(handleBtnAction), for: .touchUpInside)
//        return button
//    }()
    
    private lazy var taxButton:UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 3
        button.setImage(UIImage(named: "dollarIcon"), for: .normal)
        button.addTarget(self, action: #selector(handleBtnAction), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    lazy var numOfGroupsLabel:UILabel = {
        let numOfGroupsLabel = UILabel()
        numOfGroupsLabel.text = "-"
        numOfGroupsLabel.textAlignment = .center
        numOfGroupsLabel.textColor = .white
        numOfGroupsLabel.font = UIFont.systemFont(ofSize: 19)
        numOfGroupsLabel.adjustsFontSizeToFitWidth = true
        return numOfGroupsLabel
    }()
    
    lazy var totalBillLabel:UILabel = {
        let totalBillLabel = UILabel()
        totalBillLabel.text = "$-"
        totalBillLabel.textAlignment = .center
        totalBillLabel.textColor = .white
        totalBillLabel.font = UIFont.systemFont(ofSize: 19)
        totalBillLabel.adjustsFontSizeToFitWidth = true
        return totalBillLabel
    }()
    
    
    lazy var subTotalLabel:UILabel = {
        let subTotalLabel = UILabel()
        subTotalLabel.text = "$-"
        subTotalLabel.textAlignment = .center
        subTotalLabel.textColor = .white
        subTotalLabel.font = UIFont.systemFont(ofSize: 19)
        subTotalLabel.adjustsFontSizeToFitWidth = true
        return subTotalLabel
    }()
    
    lazy var tipLabel:UILabel = {
        let tipLabel = UILabel()
        tipLabel.text = "$-"
        tipLabel.textAlignment = .center
        tipLabel.textColor = .white
        tipLabel.font = UIFont.systemFont(ofSize: 19)
        tipLabel.adjustsFontSizeToFitWidth = true
        return tipLabel
    }()
    
    lazy var taxLabel:UILabel = {
        let taxLabel = UILabel()
        taxLabel.text = "$-"
        taxLabel.textAlignment = .center
        taxLabel.textColor = .white
        taxLabel.font = UIFont.systemFont(ofSize: 19)
        taxLabel.adjustsFontSizeToFitWidth = true
        return taxLabel
    }()
    
    var totalGroup: Int = 0 {
        didSet {
            numOfGroupsLabel.text = "\(totalGroup)"
            let twoDecimalPlaces = String(format: "%.2f", subTotal + tax + tip)
            totalBillLabel.text = "$\(twoDecimalPlaces)"
            
            let totalShareEach = (subTotal + tax + tip) / Double(totalGroup)
            let twoDecimalPlaces1 = String(format: "%.2f", totalShareEach)
            
            proportionDashBoardViewDelegate?.didChangeValue(sender: self, value: "$\(twoDecimalPlaces1)")
        }
    }
    
    var subTotal: Double = 0.00{
        didSet {
            //let roundedValue = round(subTotal * 100) / 100.0
            let twoDecimalPlaces = String(format: "%.2f", subTotal)
            subTotalLabel.text = "$\(twoDecimalPlaces)"
        }
    }
    
    var tax: Double = 0.00 {
        didSet {
            //let roundedValue = round(tax * 100) / 100.0
            let twoDecimalPlaces = String(format: "%.2f", tax)
            taxLabel.text = "$\(twoDecimalPlaces)"
        }
    }
    
    var tip: Double = 0.00 {
        didSet {
            //let roundedValue = round(tip * 100) / 100.0
            let twoDecimalPlaces = String(format: "%.2f", tip)
            tipLabel.text = "$\(twoDecimalPlaces)"
        }
    }
    
    @objc func done() {
        self.endEditing(true)
    }
    
    func checkDollarSign(text: String) -> String {
        let character: Character = "$"
        if text.contains(character) {
            return ""
        }
        
        return text
    }
    
    func setupViews() {
        addSubview(tipButton)
        tipButton.anchor(top: topAnchor, paddingTop: 20, width: 22, height: 22)
        tipButton.centerX(inView: self)
        
        addSubview(tipLabel)
        tipLabel.anchor(top: tipButton.bottomAnchor, paddingTop: 10, width: 80, height: 25)
        tipLabel.centerX(inView: tipButton)
        
        addSubview(subtotalButton)
        subtotalButton.anchor(top: topAnchor, right: tipButton.leftAnchor, paddingTop: 20, paddingRight: 70, width: 22, height: 19)
        
        addSubview(subTotalLabel)
        subTotalLabel.anchor(top: subtotalButton.bottomAnchor, paddingTop: 10, width: 80, height: 25)
        subTotalLabel.centerX(inView: subtotalButton)
        
        addSubview(taxButton)
        taxButton.anchor(top: topAnchor, left: tipButton.rightAnchor, paddingTop: 20, paddingLeft: 70, width: 12, height: 21)
        
        addSubview(taxLabel)
        taxLabel.anchor(top: taxButton.bottomAnchor, paddingTop: 10, width: 80, height: 25)
        taxLabel.centerX(inView: taxButton)
        
        
        
        addSubview(moneybtn)
        moneybtn.anchor(bottom: bottomAnchor, right: centerXAnchor, paddingBottom: 35, paddingRight: 15)
        moneybtn.setDimensions(height: 60, width: 80)
        
        addSubview(totalBillLabel)
        totalBillLabel.anchor(top: moneybtn.bottomAnchor, left: moneybtn.leftAnchor, right: moneybtn.rightAnchor, paddingTop: 5, height: 25)
        
        addSubview(groupBtn)
        groupBtn.anchor(left: centerXAnchor, bottom: bottomAnchor, paddingLeft: 15, paddingBottom: 35)
        groupBtn.setDimensions(height: 60, width: 80)
        
        addSubview(numOfGroupsLabel)
        numOfGroupsLabel.anchor(top: groupBtn.bottomAnchor, left: groupBtn.leftAnchor, right: groupBtn.rightAnchor, paddingTop: 5, height: 25)
    }
    
    func editValue(tag: Int) -> String {
        if tag == 1 {
            return subTotalLabel.text!
        } else if tag == 2 {
            return tipLabel.text!
        } else {
            return taxLabel.text!
        }
    }
    
    @objc func handleBtnAction(sender: UIButton) {
        let viewController = ProportionValuesEditor()
        viewController.proportionValuesEditorDelegate = self
        viewController.tag = sender.tag
        viewController.value = editValue(tag: sender.tag)
        viewController.modalPresentationStyle = .overCurrentContext
        returnTopMostViewController().present(viewController, animated: true)
    }
    
    func returnTopMostViewController() -> BaseViewController {
        var topController: UIViewController!
        
        if #available(iOS 13.0, *) {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            
            //let topMost = UIApplication.shared.windows.first { $0.isKeyWindow }
            topController = window?.rootViewController
        } else {
            topController = UIApplication.shared.keyWindow?.rootViewController
        }

        let top = topController as! BaseNavigationController
        return top.viewControllers.last as! BaseViewController
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
}

extension ProportionDashBoardView: ProportionValuesEditorDelegate {
    func didUpdate(sender: ProportionValuesEditor, index: Int, value: String) {
        let valueCopy = Double(value.dropFirst())
        if index == 1 {
            subTotal = valueCopy ?? 0.00
            proportionDashBoardViewDelegate?.didChangeSubtotal(sender: self, value: subTotal)
        } else if index == 2 {
            tip = valueCopy ?? 0.00
            proportionDashBoardViewDelegate?.didChangeTip(sender: self, value: tip)
        } else {
            tax = valueCopy ?? 0.00
            proportionDashBoardViewDelegate?.didChangeTax(sender: self, value: tax)
        }
        
        let totalG = totalGroup
        totalGroup = totalG
    }
}
