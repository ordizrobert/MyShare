//
//  BaseNavigationController.swift
//  MyShare
//

import Foundation
import UIKit

class BaseNavigationController : UINavigationController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationBar.isTranslucent = true
        //self.navigationBar.backgroundColor = #colorLiteral(red: 0.9375496507, green: 0.5825830102, blue: 0.4708023071, alpha: 1)
        self.navigationBar.tintColor = #colorLiteral(red: 0.2906035781, green: 0.03874258697, blue: 0.4652764797, alpha: 1)
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backIcon")
        viewController.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backIcon")
    }
}
