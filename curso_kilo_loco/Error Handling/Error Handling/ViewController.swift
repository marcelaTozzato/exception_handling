//
//  ViewController.swift
//  Error Handling
//
//  Created by Kyle Lee on 2/15/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let alertService = AlertService()
    let persistenceService = PersistenceService()
    let networkingService = NetworkingService()
    
    @IBAction func didTapTrap() {
        
        //Caso 1: Se você precisar dar fatalError no app. Você pode "lidar" com o erro exibindo uma mensagem de justificativa
        fatalError("Mensagem de erro a ser exibida no console")
    }

    @IBAction func didTapOptional() {
    
        //Caso 2: Se o xcode não conseguir desembrulhar o optional, ele não conseguirá executar o código com a variavel desembrulhada e nada irá acontecer. Você pode "lidar" com o erro exibindo um alerta com o problema, ou implementar qualquer outro tipo de funcionalidade para que o usuário saiba o que está acontecendo, ao invés de simplesmente else{return}
        
        let value: Any? = nil
        
        guard let unwrappedValue = value else {
            
            let alert = alertService.alert(message: "Informe um valor válido")
            
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        
        print (unwrappedValue)
    }
    
    
    //Lidando com erros própriamente ditos:
    @IBAction func didTapNetworking() {
        
        //O result que estamos passando nada mais é do que um enum com dois casos, sucesso ou falha. Caso retorne sucesso, seguimos com o nosso código e podemos utilizar o valor retornado. Caso de falha, temos que lidar com o erro que ele irá retornar:
        
        //Como estamos dentro de uma closure, vamos utilizar uma weak reference to self
        
        networkingService.makeRequest { [weak self] (result) in
            
            switch result {
            case .success(let message): print(message)
                
            case .failure(let error):
                //Como self é o weak, é optional, portanto temos que desembrulhar
                guard let alert = self?.alertService.alert(message: error.localizedDescription) else {return}
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func didTapSave() {
        
        //forceSave()
        //attemptSave()
        handleSaveProperly()
        print ("Vamos executar algum código aqui....")
    }
    
    //Criando 3 funções para verificar como o try funciona:
    //Caso 1: força o unwrap e se der algum erro, vai dar fatal error no app e nada depois é executado
    //Caso 2: mantem o try como optional, ou seja, se não conseguir desembrulhar, não tem problema, esse valor não é essencial, portanto o código a seguir continua a ser executado como se nada tivesse acontecido - "Vamos executar algum código aqui...." é impresso no console
    //Caso 3: do-try-catch: tenta fazer o try, se der certo significa que conseguiu salvar, se der erro, você consegue capturar o erro e lidar com ele corretamente - "Vamos executar algum código aqui...." é impresso no console
    
    func forceSave() {
        
        try! persistenceService.Save()
    }
    
    func attemptSave() {
        
        try? persistenceService.Save()
    }
    
    func handleSaveProperly() {
        
        var alert: UIAlertController?
        
        do {
            try persistenceService.Save()
            print ("Salvo com sucesso!")
            
        } catch PersistenceError.invalidcontext {
            
            alert = alertService.alert(message: "Não foi possível salvar")
            
        } catch PersistenceError.failedWriteToDisk {
            
            alert = alertService.alert(message: "Há algum problema com o contexto")
            
        } catch {
            
            alert = alertService.alert(message: "O app crashou")
        }
        
        if let alert = alert {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

