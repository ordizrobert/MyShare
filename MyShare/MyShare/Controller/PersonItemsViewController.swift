//
//  PersonItemsViewController.swift
//  MyShare
//
//  Created by robert ordiz on 4/20/23.
//

import Foundation
import UIKit

protocol PersonItemsViewControllerDelegate: AnyObject {
    func didUpdate(sender: PersonItemsViewController, index: IndexPath, updatedValue: EachShareData)
}

class PersonItemsViewController: BaseViewController, UIGestureRecognizerDelegate {
    weak var personItemsViewControllerDelegate: PersonItemsViewControllerDelegate?
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
        //inputValuesTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        inputValuesTextField.keyboardType = .default
        inputValuesTextField.textAlignment = .center
        inputValuesTextField.font = UIFont.systemFont(ofSize: 28)
        inputValuesTextField.textColor = .white
        inputValuesTextField.layer.borderColor = UIColor.darkGray.cgColor
        inputValuesTextField.layer.borderWidth = 1
        inputValuesTextField.layer.cornerRadius = 5
        inputValuesTextField.layer.masksToBounds = true
        inputValuesTextField.setLeftPaddingPoints(5)
        inputValuesTextField.setRightPaddingPoints(5)
        return inputValuesTextField
    }()
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.backgroundColor = .clear
        tableView.alwaysBounceVertical = false
        tableView.separatorColor = .lightGray
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = true
        tableView.allowsMultipleSelection = false
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.cellReuseID())
        return tableView
    }()
    
    private lazy var doneButton:UIButton = {
        let doneButton = UIButton(type: .custom)
        doneButton.setImage(UIImage(named: "checkMark"), for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.layer.cornerRadius = 20
        doneButton.backgroundColor = #colorLiteral(red: 0.2906035781, green: 0.03874258697, blue: 0.4652764797, alpha: 1)
        doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        return doneButton
    }()
    
    var data: EachShareData! = nil {
        didSet {
            inputValuesTextField.text = data.name
        }
    }
    
    var totalDifference: Double! = 0.0
    
    var index: IndexPath! = nil
    
    override func setupViews() {
        view.addSubview(inputValuesTextField)
        inputValuesTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20, width: 250, height: 50)
        inputValuesTextField.centerX(inView: view)
        
        let logoImage = UIImageView()
        logoImage.contentMode = .scaleAspectFit
        logoImage.image = UIImage(named: "personImage")
        
        view.addSubview(logoImage)
        logoImage.anchor(top: inputValuesTextField.topAnchor, bottom: inputValuesTextField.bottomAnchor, right: inputValuesTextField.leftAnchor, paddingRight: 15, width: 30,height: 30)
        
        view.addSubview(doneButton)
        doneButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 100)
        doneButton.centerX(inView: view)
        doneButton.setDimensions(height: 40, width: 40)
        
        let addBtn = UIButton(type: .custom)
        addBtn.setImage(UIImage(named: "addItem"), for: .normal)
        addBtn.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        view.addSubview(addBtn)
        
        addBtn.centerX(inView: view)
        addBtn.anchor(bottom: doneButton.topAnchor, paddingBottom: 15, width: 40, height: 40)
        
        view.addSubview(tableView)
        tableView.anchor(top: inputValuesTextField.bottomAnchor, left: view.leftAnchor, bottom: addBtn.topAnchor, right: view.rightAnchor, paddingTop: 20, paddingBottom: 10)
        
        if data.items?.count == 0 {
            data.items?.append(Items(price: 0.00, item: "Item Name"))
        }
    }
    
    @objc func addAction() {
        data.items?.append(Items(price: 0.00, item: "Item Name"))
        tableView.reloadData()
    }
    
    @objc func done() {
        view.endEditing(true)
    }
    
    @objc func doneAction() {
        if inputValuesTextField.text!.count > 0 {
            data.name = inputValuesTextField.text
            let itemsData = self.data.items!.filter { ($0.price != 0.00)}
            data.items = itemsData
            personItemsViewControllerDelegate?.didUpdate(sender: self, index: index, updatedValue: data)
            closeViewController()
        }
        done()
    }
}

extension PersonItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemCell = (tableView.dequeueReusableCell(withIdentifier: ItemCell.cellReuseID(), for: indexPath) as? ItemCell)!
        cell.data = data.items![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let datacopy = data.items![indexPath.row]
        let viewController = ItemEditorViewController()
        viewController.totalDifference = self.totalDifference
        viewController.data = datacopy
        viewController.index = indexPath
        viewController.itemEditorViewControllerDelegate = self
        viewController.modalPresentationStyle = .overCurrentContext
        navigationController!.present(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data.items?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
}

extension PersonItemsViewController: ItemEditorViewControllerDelegate {
    func didUpdate(sender: ItemEditorViewController, index: IndexPath, updatedValue: Items) {
        var allItems: Double! = 0.0
        for n in 0..<data.items!.count {
            if n == index.row {
                allItems = allItems + updatedValue.price!
            } else {
                allItems = allItems + (data.items?[n].price)!
            }
        }
        
        if allItems > totalDifference {
            _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                self.showSimpleAlert(withTitle: "Warning", withMessage: "Invalid input! \(self.data.name ?? "") items price is higher than the difference between subtotal and all existing items.", withOKButtonTitle: "OK")
            }
            
            for n in 0..<data.items!.count {
                if n == index.row {
                    data.items![n].price = 0.0
                    break
                }
            }
        } else {
            data.items![index.row] = updatedValue
            tableView.reloadData()
        }
    }
}
