//
//  HttpsUtility.swift
//  AssignmentTest
//
//  Created by Praveen Kumar on 03/05/24.
//

import Foundation

struct HttpsUtility {
    
    func getData<T:Decodable>(reuestUrl: URL, resultType: T.Type, completionHandler: @escaping(_ result: T) -> Void){
        
        var urlRequest =  URLRequest(url: reuestUrl)
        urlRequest.httpMethod = "get"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        URLSession.shared.dataTask(with: reuestUrl) { data, httpUrlResponse, error in
            if error == nil && data != nil && data?.count != 0{
                do{
                    let response = try JSONDecoder().decode(T.self, from: data!)
                    _ = completionHandler(response)
                }catch let error{
                    debugPrint(error)
                }
            }
        }.resume()
    }
}

