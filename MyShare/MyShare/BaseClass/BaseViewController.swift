//
//  BaseController.swift
//  MyShare
//

import Foundation
import UIKit
import SwiftyBeaver

class BaseViewController: UIViewController {
    let log = SwiftyBeaver.self
    override func viewDidLoad() {
        super.viewDidLoad()
        let console = ConsoleDestination()  // log to Xcode Console
        log.addDestination(console)
        view.backgroundColor = .white
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
