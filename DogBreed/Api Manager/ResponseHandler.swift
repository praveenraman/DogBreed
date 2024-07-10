//
//  ResponseHandler.swift
//  DogBreed
//
//  Created by Praveen Kumar on 09/07/24.
//

import Foundation

class ResponseHandler {
    func getResponse<T: Decodable>(type: T.Type, data: Data, completion: @escaping(Result<T, DemoError>) -> Void){
        
        let response = try? JSONDecoder().decode(type.self, from: data)
        if let response = response {
            completion(.success(response))
        }else{
            completion(.failure(.DecodingError))
        }
    }
}
