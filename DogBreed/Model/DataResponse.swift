//
//  DataResponse.swift
//  AssignmentTest
//
//  Created by Praveen Kumar on 03/05/24.
//

import Foundation

struct DataResponse: Decodable {
    var message: [String]
    var status: String
}

struct BreedData{
    var message: String
    var isSelected: Bool = false
    
    init(message: String, isSelected: Bool){
        self.message = message
        self.isSelected = isSelected
    }
}

class FavoriteBreedResponse{
    static let shared = FavoriteBreedResponse()
    var breedData = [BreedData]()
    private init() {}
}
