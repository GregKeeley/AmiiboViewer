//
//  UIViewController Ext.swift
//  AmiiboViewer
//
//  Created by Gregory Keeley on 1/7/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

extension UIViewController {
  func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Load Amiibos", style: .default, handler: completion)
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
}
