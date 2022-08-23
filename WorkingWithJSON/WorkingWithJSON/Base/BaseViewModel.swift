//
//  BaseViewModel.swift
//  QuizupElcom
//
//  Created by Tuyen on 3/20/18.
//  Copyright © 2018 Tuyen. All rights reserved.
//

import UIKit
import PKHUD

class BaseViewModel {
    
    func showHUD() {
        PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
        PKHUD.sharedHUD.show()
    }


    func hideHUD() {
       PKHUD.sharedHUD.hide()
    }

    func showAlert(message: String) {
        if #available(iOS 8, *) {
            let alertController = UIAlertController(title: "", message: message.localized, preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "OK".localized,
                                         style: .default,
                                         handler: nil)

            alertController.addAction(actionOk)
//            Util.shared.returnHomeController()?.present(alertController, animated: true, completion: nil)
        }else {
                let alertView = UIAlertView(title: "", message: message.localized, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK".localized)
                alertView.show()
        }
    }

}
