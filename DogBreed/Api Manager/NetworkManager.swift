//
//  NetworkManager.swift
//  SOLID
//
//  Created by Praveen Kumar on 09/07/24.
//

import Foundation

enum DemoError: Error {
    case BadUrl
    case NoData
    case DecodingError
}


class NetworkManager {
    
    let apiHandler: APIHandler
    let responseHandler: ResponseHandler
    
    init(apiHandler: APIHandler = APIHandler(), responseHandler: ResponseHandler = ResponseHandler()) {
        self.apiHandler = apiHandler
        self.responseHandler = responseHandler
    }
    
    func getApiData<T: Decodable>(url: URL, type: T.Type, completion: @escaping(Result<T, DemoError>) -> Void){
        apiHandler.getApiResponse(url: url) { result in
            switch result {
            case .success(let data):
                self.responseHandler.getResponse(type: type, data: data) { deCodedata in
                    switch deCodedata {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                         completion(.failure(error))
                    }
                }
            case .failure(let error):
                 completion(.failure(error))
            }
        }
    }
}
