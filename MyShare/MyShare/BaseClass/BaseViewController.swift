//
//  BaseController.swift
//  MyShare
//

import Foundation
import UIKit
import SwiftyBeaver

class BaseViewController: UIViewController {
    let log = SwiftyBeaver.self
    
    var shouldShowBackButton: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let console = ConsoleDestination()  // log to Xcode Console
        log.addDestination(console)
        view.backgroundColor = .white
        view.setGradientBackground(colors: [#colorLiteral(red: 0.7564757466, green: 0.4687396288, blue: 0.9820383191, alpha: 1).cgColor, #colorLiteral(red: 0.630576551, green: 0.3288735151, blue: 0.8758888841, alpha: 1).cgColor, #colorLiteral(red: 0.5067917705, green: 0.1973252296, blue: 0.7646642327, alpha: 1).cgColor])
        setupInitialConfiguration()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override var shouldAutorotate: Bool {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return false
        } else {
            return false
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.portrait
        } else {
            return UIInterfaceOrientationMask.portrait
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func showSimpleAlert(withTitle alertTitle: String, withMessage alertMessage: String, withOKButtonTitle okButtonTitle: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: okButtonTitle, style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func setupViews() {
    }
    
    func setupInitialConfiguration() {
        if !shouldShowBackButton {
            navigationItem.hidesBackButton = true
        }
    }
    
    @objc func closeModal() {
        self.dismiss(animated: true) {}
    }
    
    @objc func closeViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func popToRootViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
