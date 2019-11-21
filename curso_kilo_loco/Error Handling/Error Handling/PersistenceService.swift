//
//  PersistenceService.swift
//  Error Handling
//
//  Created by Kyle Lee on 2/15/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import Foundation

class PersistenceService {
    
    func Save() throws {
        
        let isNewTopic = true
        let isValidContext = false
        let canWriteToDisk = false
        
        guard isNewTopic else { throw NSError(domain: "Opss", code: 80085, userInfo: nil)}
        guard isValidContext else { throw PersistenceError.invalidcontext}
        guard canWriteToDisk else { throw PersistenceError.failedWriteToDisk}
        
        print ("Conseguimos salvar!!!")
    }
}

//Throw lança um Error, portanto o enum precisa estar em conformidade com esse protocolo
enum PersistenceError: Error {
    
    case invalidcontext
    case failedWriteToDisk
    
}
