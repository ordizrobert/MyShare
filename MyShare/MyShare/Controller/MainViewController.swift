//
//  MainViewController.swift
//  MyShare
//
//  Created by robert ordiz on 4/16/23.
//

import UIKit

class MainViewController: BaseViewController {
    private lazy var evenBtn:UIButton = {
        let button = UIButton(type: .system)
        button.tag = 0
        button.setTitle("EVENLY", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(handleBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var proportionBtn:UIButton = {
        let button = UIButton(type: .system)
        button.tag = 1
        button.setTitle("PROPORTION", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(handleBtnAction), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MyShare"
    }
    
    override func setupViews() {
        let topLabel = UILabel()
        topLabel.text = "HOW DO YOU WANT TO SPLIT YOUR CHECK?"
        topLabel.textAlignment = .center
        topLabel.textColor = .black
        topLabel.numberOfLines = 2
        topLabel.font = UIFont.boldSystemFont(ofSize: 21)
        view.addSubview(topLabel)
        
        topLabel.setHeight(100)
        topLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10)
        
        view.addSubview(evenBtn)
        evenBtn.setDimensions(height: 75, width: 225)
        evenBtn.anchor(bottom: view.centerYAnchor, paddingBottom: 20)
        evenBtn.centerX(inView: view)
        
        view.addSubview(proportionBtn)
        proportionBtn.setDimensions(height: 75, width: 225)
        proportionBtn.anchor(top: view.centerYAnchor, paddingTop: 20)
        proportionBtn.centerX(inView: view)
    }
    
    @objc func handleBtnAction(sender: UIButton) {
        var viewController: BaseViewController!
        if sender.tag > 0 {
            viewController = ProportionViewController()
            navigationController?.pushViewController(viewController, animated: true)
            return
        }
        
        viewController = EvenViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
