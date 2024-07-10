//
//  AppUrls.swift
//  DogBreed
//
//  Created by Praveen Kumar on 09/07/24.
//

import Foundation

class Urls {
    
    static let baseURL = "https://dog.ceo/api"
    
    class func breedListUrl() -> String {
        return baseURL + "/breeds/list"
    }
    
    class func breedImagesUrl(imgName: String) -> String {
        return baseURL + "/breed/\(imgName)/images"
    }
}
