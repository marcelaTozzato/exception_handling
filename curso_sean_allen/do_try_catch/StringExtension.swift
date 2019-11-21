//
//  StringExtension.swift
//  do_try_catch
//
//  Created by Marcela Limieri Tozzato on 21/11/19.
//  Copyright © 2019 Marcela Limieri Tozzato. All rights reserved.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}
