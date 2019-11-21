//
//  AlertService.swift
//  Error Handling
//
//  Created by Kyle Lee on 2/15/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import UIKit

class AlertService {
    
    func alert(message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        return alert
    }
}
