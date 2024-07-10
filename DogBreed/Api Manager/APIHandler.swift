//
//  APIHandler.swift
//  DogBreed
//
//  Created by Praveen Kumar on 09/07/24.
//

import Foundation

class APIHandler{
    func getApiResponse(url: URL, completion: @escaping(Result<Data, DemoError>) -> Void){
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else{
                return completion(.failure(.NoData))
            }
             completion(.success(data))
        }.resume()
    }
}
