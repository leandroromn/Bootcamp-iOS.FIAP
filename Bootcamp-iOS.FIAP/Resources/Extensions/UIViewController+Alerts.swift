//
//  UIViewController+Alerts.swift
//  Bootcamp-iOS.FIAP
//
//  Created by Leandro Romano on 27/07/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func displayAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Constants.closeButtonLabel, style: .default))
        present(alertController, animated: true)
    }
    
}
