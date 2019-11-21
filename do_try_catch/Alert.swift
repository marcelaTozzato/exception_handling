//
//  Alert.swift
//  do_try_catch
//
//  Created by Marcela Limieri Tozzato on 21/11/19.
//  Copyright © 2019 Marcela Limieri Tozzato. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    func showAlert(title: String, message: String, vc: UIViewController) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertBtn: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertBtn)
        vc.present(alert, animated: true, completion: nil)
    }
}
