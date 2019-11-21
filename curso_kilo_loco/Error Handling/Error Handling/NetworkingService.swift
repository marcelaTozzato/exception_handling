//
//  NetworkingService.swift
//  Error Handling
//
//  Created by Kyle Lee on 2/15/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import Foundation

//O "Result" do swift nada mais é do que este enum incorporado na linguagem. O bloco irá retornar um resultado. Caso seja sucesso irá retornar um valor T (genérico). Caso de erro, irá retornar o erro (que atende ao protocolo Error)
enum MyResult<T, E: Error> {
    case sucess (T)
    case failure (E)
}

class NetworkingService {

    
    //Exemplo básico de como um network funciona: primeiro testa se a requisição teve sucesso, caso não seja - lidar com o erro, caso seja - verificar se a resposta é válida, caso não seja - lidar com o erro, caso seja - ótimo, seguir com o código
    
    func makeRequest(completion: @escaping (Result<String, NetworkingError>) -> Void){
        
        let isSuccessfulRequest = true
        
        if isSuccessfulRequest {
            
            let isValidResponse = false
            
            if isValidResponse {
                
                completion(.success("A sua requisição foi um sucesso"))
                
            } else {
                
                completion(.failure(.invalidResponse))
                
            }
        } else {
            
            //.failure é o case do enum incorporado a linguagem
            //Caso falhe vamos passar um erro. Como tipamos o erro com o nosso enum, o erro não é um Error genérico, sempre será um NetworkingError, portanto não precisamos fazer NetworkingError.invalidRequest
            completion(.failure(.invalidRequest))
        }
    }
}

//Ao lidar com requisições, temos tipos especificos de erros que podem ocorrer. Não queremos lançar um erro genérico, portanto vamos criar um enum com erros customizados:
//Estamos em conformidade com o protocolo Error, o que significa que nós podemos lançar(throw) nosso NetworkingError sempre que quisermos, ou então podemos passar como Error.
enum NetworkingError: String, Error {
    
    case invalidRequest = "Você fez uma requisição invalida"
    case invalidResponse = "Há alguma coisa errada com a resposta que recebemos"
}

//Error tem um propriedade chamada localizedDescription, que é uma String com a descrição do erro. Porém o erro não é legível. Podemos corrigir esse problema criando uma extensão para a NetworkingError que esteja em conformidade com o protocolo LocalizedError. Assim conseguimos acessar a stored propertie errorDescription e fazer com que ela retorne o que nós queremos. Como ela retorna uma String, precisamos que a Networking error esteja em conformidade com String, para que para cada tipo de erro possamos passar uma mensagem diferente
extension NetworkingError: LocalizedError {
    
    var errorDescription: String? { return NSLocalizedString(rawValue, comment: "")}
}
