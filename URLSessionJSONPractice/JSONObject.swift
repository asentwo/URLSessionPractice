//
//  JSONObjects.swift
//  URLSessionJSONPractice
//
//  Created by Justin Doo on 1/7/17.
//  Copyright © 2017 JustinDoo. All rights reserved.
//

import Foundation

class JSONObject: CustomStringConvertible {
  
  private let baseImageURL = "https://nomadlist.com"
  
  var costDictionary: [String: Any]
  var airbnbDetails: [String: Any]
  var airbnbUS: Int
  var airbnbLocal: Int
  var mediaDictionary: [String: Any]
  var imageDictionary: [String: Any]
  var imageString: String
  var image: URL
  
  
  init(costDictionary: [String: Any], airbnbDetails: [String: Any], airbnbUS: Int, airbnbLocal: Int, mediaDictionary: [String: Any], imageDictionary: [String: Any], imageString: String, image: URL){
    
    self.costDictionary = costDictionary
    self.airbnbDetails = airbnbDetails
    self.airbnbUS = airbnbUS
    self.airbnbLocal = airbnbLocal
    self.mediaDictionary = mediaDictionary
    self.imageDictionary = imageDictionary
    self.imageString = imageString
    self.image = image
  }
  
  init(resultsDictionary:[String: Any]){
    
    costDictionary = (resultsDictionary["cost"] as? [String: Any])!
    airbnbDetails = (costDictionary["airbnb_median"] as? [String: Any])!
    airbnbUS = (airbnbDetails["USD"] as? Int)!
    airbnbLocal = (airbnbDetails["CHF"] as? Int)!
    mediaDictionary = (resultsDictionary["media"] as? [String: Any])!
    imageDictionary = (mediaDictionary["image"] as? [String: Any])!
    imageString = (imageDictionary["1000"] as! String)
    image = URL(string: "\(baseImageURL)\(imageString)")!
  }
  
  var description: String {
    return "SampleJSON(cost: \(self.costDictionary), airbnb: \(self.airbnbDetails), airbnb US: \(self.airbnbUS), airbnb local: \(self.airbnbLocal))"
  }
  
  
  static func updateResultsDictionary(urlExtension: String, completion:
    @escaping (JSONObject?) -> Void) {
   
    
    let nm = NetworkManager.sharedManager
    
    _ = nm.getJSONData(urlExtension: urlExtension) {data in
   
      guard let jsonDictionary = nm.parseJSONFromData(data), let
        
        resultDictionaries = jsonDictionary["result"] as?
       
        [[String : Any]] else {
      
          completion(nil)
      
          return
      }
      
      for resultsDictionary in resultDictionaries {// enumerate through dictionary
        let jsonInfo = JSONObject(resultsDictionary: resultsDictionary)
        
        print(jsonInfo.image)
        
        completion(jsonInfo)
     
      }
    }
  }
  
}






