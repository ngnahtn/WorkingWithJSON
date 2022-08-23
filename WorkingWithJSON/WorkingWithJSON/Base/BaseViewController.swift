//
//  BaseViewController.swift
//  Tutor
//
//  Created by Tuyen on 2/11/18.
//  Copyright © 2018 Tuyen. All rights reserved.
//

import UIKit
import UIAlertView_Blocks
import PKHUD


class BaseViewController: UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
//        self.transitioningDelegate = self
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.modalPresentationStyle = .custom
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func convertNextDate(dateString : String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let myDate = dateFormatter.date(from: dateString)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: myDate)
        let somedateString = dateFormatter.string(from: tomorrow!)
        print("your next Date is \(somedateString)")
        return somedateString
    }
    
    func convertBackDate(dateString : String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let myDate = dateFormatter.date(from: dateString)!
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: myDate)
        let somedateString = dateFormatter.string(from: yesterday!)
        print("your back Date is \(somedateString)")
        return somedateString
    }

    
}



public extension UIViewController {

    func showHUD(_ message: String) {
        DispatchQueue.main.async {
            PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
            PKHUD.sharedHUD.show(onView: self.view)
        }
        
    }

    func showHUD() {
        DispatchQueue.main.async {
            PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
            PKHUD.sharedHUD.show(onView: self.view)
        }
        
    }

    func hideLoadingHub() {
        DispatchQueue.main.async {
            PKHUD.sharedHUD.hide()
        }
       
    }

    func showOnView() {
        DispatchQueue.main.async {
            PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
            PKHUD.sharedHUD.show(onView: self.view)
        }
        
    }

    func hideHUD() {
        DispatchQueue.main.async {
            PKHUD.sharedHUD.hide()
        }
    }


    func showAlertPresent(_ message: String) {

            let alertController = UIAlertController(title: "", message: message.localized, preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "OK".localized,
                                         style: .default,
                                         handler: nil)

            alertController.addAction(actionOk)
            
        if UIDevice.current.userInterfaceIdiom == .phone {
           print("running on iPhone")
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            
            
            alertController.popoverPresentationController?.sourceView = self.view
            alertController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            alertController.popoverPresentationController?.permittedArrowDirections = []
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func showApiErrorAlert() {
        showAlertPresent("Đã có lỗi xảy ra, vui lòng thử lại sau")
    }

    func dismissController(_ animated: Bool = true)
    {
        self.dismiss(animated: animated, completion: nil)
    }

    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }

    func popToRootViewController(controller: UIViewController!) {
        if controller == nil {
            return
        }
        self.navigationController?.popToViewController(controller, animated: true)
    }

    func pushViewController(viewController: UIViewController!) {
        if viewController == nil { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func popViewQuestion()
    {
        let transition = CATransition()
        transition.duration = 0.45
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.popViewController(animated: true)
    }

    func popToViewQuestion(controller: UIViewController!)
    {
        if controller == nil {
            return
        }
        let transition = CATransition()
        transition.duration = 0.45
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.popToViewController(controller, animated: true)
    }

    func pushViewQuestion(viewController: UIViewController!)
    {
        if viewController == nil { return }
        let transition = CATransition()
        transition.duration = 0.45
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func presentViewController(viewController: UIViewController!) {
        if viewController == nil { return }
        self.present(viewController, animated: true, completion: nil)
    }
}

extension UIViewController {
    static func loadFromNib() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
}
