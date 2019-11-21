//
//  ViewController.swift
//  do_try_catch
//
//  Created by Marcela Limieri Tozzato on 21/11/19.
//  Copyright © 2019 Marcela Limieri Tozzato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum LoginError: Error {
        case incompleteForm
        case invalidEmail
        case incorrectPasswordLength
    }
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        do {
            try login()
        } catch LoginError.incompleteForm {
            Alert().showAlert(title: "Valores não preenchidos", message: "Favor informar e-mail e senha válidos", vc: self)
        } catch LoginError.invalidEmail {
            Alert().showAlert(title: "Email inválido", message: "Favor informar o email corretamente ", vc: self)
        } catch LoginError.incorrectPasswordLength {
            Alert().showAlert(title: "Senha muito curta", message: "Favor informar uma senha com no mínimo 8 caracteres", vc: self)
        } catch {
            Alert().showAlert(title: "Erro", message: "Não foi possível fazer login", vc: self)
        }
    }
    
    func login() throws {
        let email = emailTxt.text!
        let password = passwordTxt.text!
        
        if email.isEmpty || password.isEmpty {
            throw LoginError.incompleteForm
        }
        
        if !email.isValidEmail {
            throw LoginError.invalidEmail
        }
        
        if password.count < 8 {
            throw LoginError.incorrectPasswordLength
        }
    }

}

