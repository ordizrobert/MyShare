//
//  ProportionDashboardViewControlller.swift
//  MyShare
//
//  Created by robert ordiz on 4/18/23.
//

import Foundation
import UIKit

class ProportionDashboardViewController: BaseViewController {
    private lazy var proportionView:ProportionDashBoardView = {
        let proportionView = ProportionDashBoardView()
        proportionView.proportionDashBoardViewDelegate = self
        return proportionView
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
        tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.cellReuseID())
        return tableView
    }()
    
    var totalShareEach: String? = nil {
        didSet {
            tableView.reloadData()
        }
    }
    
    var data: [EachShareData]! = []
    var totalGroup: Int = 0
    var subTotal: Double = 0.0
    var tax: Double = 0.0
    var tip: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for n in 0..<totalGroup {
            data.append(EachShareData(name: "Person \(n+1)"))
        }
        let homeButton = UIBarButtonItem(image: UIImage(named: "homeBtn"),  style: .plain, target: self, action: #selector(homeAction))
        navigationItem.rightBarButtonItem = homeButton
    }
    
    override func setupViews() {
        proportionView.tax = self.tax
        proportionView.tip = self.tip
        proportionView.subTotal = self.subTotal
        proportionView.totalGroup = self.totalGroup

        view.addSubview(proportionView)
        proportionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, height: 200)
        
        view.addSubview(tableView)
        tableView.anchor(top: proportionView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingBottom: 65)
        
        let doneButton = UIButton(type: .custom)
        doneButton.setImage(UIImage(named: "addPerson"), for: .normal)
        doneButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        view.addSubview(doneButton)
        
        doneButton.centerX(inView: tableView)
        doneButton.anchor(top: tableView.bottomAnchor, paddingTop: 15, width: 40, height: 40)
    }
    
    @objc func addAction() {
        totalGroup += 1
        data.append(EachShareData(name: "New Person"))
        tableView.reloadData()
        proportionView.totalGroup = totalGroup
    }
    
    @objc func homeAction() {
        popToRootViewController()
    }
}

extension ProportionDashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PersonCell = (tableView.dequeueReusableCell(withIdentifier: PersonCell.cellReuseID(), for: indexPath) as? PersonCell)!
        cell.tag = indexPath.row + 1
        cell.totalShare = checkShare(index: indexPath)
        cell.data = data[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewConroller = PersonItemsViewController()
        viewConroller.personItemsViewControllerDelegate = self
        viewConroller.index = indexPath
        viewConroller.data = data[indexPath.row]
        viewConroller.totalDifference = checkTotalDifference()
        navigationController?.pushViewController(viewConroller, animated: true)
    }
    
    func checkTotalDifference() -> Double {
        var filteredData: [EachShareData]! = []
        filteredData = self.data.filter { ($0.items!.count != 0)}
        
        if filteredData.count > 0 {
            var allItems: Double! = 0.0
            for i in 0..<filteredData.count {
                for n in 0..<filteredData[i].items!.count {
                    allItems = allItems + (filteredData[i].items![n].price)!
                }
            }
            
            return subTotal - allItems
        }
        
        return subTotal
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            totalGroup -= 1
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            proportionView.totalGroup = totalGroup
        }
    }
    
    func checkShare(index: IndexPath) -> String {
        if data[index.row].items!.count > 0 {
            var allItems: Double! = 0.0
            for n in 0..<data[index.row].items!.count {
                allItems = allItems + (data[index.row].items?[n].price)!
            }
            
            let percentage = (allItems / subTotal) * 100.0
            allItems = allItems + calculatePercentage(value: tax, percentageVal: percentage)
            allItems = allItems + (tip / Double(totalGroup))
            
            return "$\(allItems.roundToDecimal(2))"
        } else {
            var filteredData: [EachShareData]! = []
            filteredData = self.data.filter { ($0.items!.count != 0)}
            
            if filteredData.count > 0 {
                var allItems: Double! = 0.0
                for i in 0..<filteredData.count {
                    for n in 0..<filteredData[i].items!.count {
                        allItems = allItems + (filteredData[i].items![n].price)!
                    }
                }
                
                let percentage = (allItems / subTotal) * 100.0
                let dataCount = self.data.filter { ($0.items!.count == 0)}
                var total = subTotal - allItems
                total = total / Double(dataCount.count)
                let taxToNoItems = (tax - calculatePercentage(value: tax, percentageVal: percentage)) / Double(dataCount.count)
                total = total + taxToNoItems + (tip / Double(totalGroup))
                
                return "$\(total.roundToDecimal(2))"
                
            }
            
            let totalDecimal: Double = (subTotal / Double(totalGroup)).roundToDecimal(2) + (tip / Double(totalGroup)) + (tax / Double(totalGroup))
            
            return "$\(totalDecimal.roundToDecimal(2))"
        }
    }
    
    func calculatePercentage(value:Double,percentageVal:Double) -> Double{
        let val = value * percentageVal
        return val / 100.0
    }
}

extension ProportionDashboardViewController: ProportionDashBoardViewDelegate {
    func didChangeTip(sender: ProportionDashBoardView, value: Double) {
        self.tip = value.roundToDecimal(2)
        tableView.reloadData()
    }
    
    func didChangeTax(sender: ProportionDashBoardView, value: Double) {
        self.tax = value.roundToDecimal(2)
        tableView.reloadData()
    }
    
    func didChangeSubtotal(sender: ProportionDashBoardView, value: Double) {
        self.subTotal = value.roundToDecimal(2)
        tableView.reloadData()
    }
    
    func didChangeValue(sender: ProportionDashBoardView, value: String) {
        self.totalShareEach = value
    }
}

extension ProportionDashboardViewController: PersonItemsViewControllerDelegate {
    func didUpdate(sender: PersonItemsViewController, index: IndexPath, updatedValue: EachShareData) {
        data[index.row] = updatedValue
        tableView.reloadData()
    }
}
