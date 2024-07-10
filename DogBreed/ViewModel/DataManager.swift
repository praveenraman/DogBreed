//
//  DataManager.swift
//  AssignmentTest
//
//  Created by Praveen Kumar on 03/05/24.
//

import Foundation

struct DataManager {
    
    func getData(url: String, completionHandler: @escaping(_ result: DataResponse) -> Void){
        let httpUtility = HttpsUtility()
        do {
            httpUtility.getData(reuestUrl: URL(string: url)!, resultType: DataResponse.self) { response in
                _ = completionHandler(response)
            }
        }catch let error{
           print(error)
        }
    }
    
    func getDogsBreedsResponse(completionHandle: @escaping(Result<DataResponse, DemoError>) -> Void){
        guard let url = URL(string: Urls.breedListUrl()) else {
            return completionHandle(.failure(.BadUrl))
        }
        NetworkManager().getApiData(url: url, type: DataResponse.self, completion: completionHandle)
    }
    
    func getDogsBreedsRandomResponse(url: String, completionHandle: @escaping(Result<DataResponse, DemoError>) -> Void){
        guard let url = URL(string: url) else {
            return completionHandle(.failure(.BadUrl))
        }
        NetworkManager().getApiData(url: url, type: DataResponse.self, completion: completionHandle)
    }
}
