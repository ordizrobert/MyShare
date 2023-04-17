//
//  EvenViewController.swift
//  MyShare
//
//  Created by robert ordiz on 4/17/23.
//

import Foundation
import UIKit

class EvenViewController: BaseViewController {
    private lazy var evenComputationView:EvenlyComputationView = {
        let evenComputationView = EvenlyComputationView()
        return evenComputationView
    }()
    
    override var shouldShowBackButton: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupViews() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "homeBtn"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(homeAction), for: .touchUpInside)
        
        view.addSubview(button)
        button.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        button.centerX(inView: view)
        button.setDimensions(height: 25, width: 25)
        
        view.addSubview(evenComputationView)
        evenComputationView.anchor(top: button.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10)
        evenComputationView.setHeight(300)
    }
    
    @objc func homeAction() {
        popToRootViewController()
    }
}
