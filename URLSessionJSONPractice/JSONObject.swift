//
//  JSONObjects.swift
//  URLSessionJSONPractice
//
//  Created by Justin Doo on 1/7/17.
//  Copyright © 2017 JustinDoo. All rights reserved.
//

import Foundation

class JSONObject: CustomStringConvertible {
    
  var costDictionary: [String: Any]
  var airbnbDetails: [String: Any]
  var airbnbUS: Int
  var airbnbLocal: Int
  var mediaDictionary: [String: Any]
  var imageDictionary: [String: Any]
  var image: URL
  
  
  init(costDictionary: [String: Any], airbnbDetails: [String: Any], airbnbUS: Int, airbnbLocal: Int, mediaDictionary: [String: Any], imageDictionary: [String: Any], image: URL){
    
    self.costDictionary = costDictionary
    self.airbnbDetails = airbnbDetails
    self.airbnbUS = airbnbUS
    self.airbnbLocal = airbnbLocal
    self.mediaDictionary = mediaDictionary
    self.imageDictionary = imageDictionary
    self.image = image
    
    
  }
  
  init(resultsDictionary:[String: Any]){
    
    costDictionary = (resultsDictionary["cost"] as? [String: Any])!
    airbnbDetails = (costDictionary["airbnb_median"] as? [String: Any])!
    airbnbUS = (airbnbDetails["USD"] as? Int)!
    airbnbLocal = (airbnbDetails["CHF"] as? Int)!
    mediaDictionary = (resultsDictionary["media"] as? [String: Any])!
    imageDictionary = (mediaDictionary["image"] as? [String: Any])!
    image = URL(string: imageDictionary["1000"] as! String)!
  }
  
  var description: String {
    return "SampleJSON(cost: \(self.costDictionary), airbnb: \(self.airbnbDetails), airbnb US: \(self.airbnbUS), airbnb local: \(self.airbnbLocal))"
  }
  
  
  static func updateResultsDictionary(urlExtension: String, completion:
    @escaping (JSONObject?) -> Void) {
   
  //  var jsonDataArray = [JSONObject]()
    
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
        
       // jsonDataArray.append(jsonInfo)
        
       // completion(jsonDataArray)
        
        print(jsonInfo.image)
        
        completion(jsonInfo)
     
      }
    }
  }
  
//  static func updateResultsDictionary(urlExtension: String, completion: @escaping ([JSONObject]) -> Void){
//    
//    var jsonDataArray = [JSONObject]()
//    
//    let nm = NetworkManager.sharedManager
//    
//    _ = nm.getJSONData(urlExtension: urlExtension, completion: {data in
//      
//      if let jsonDictionary = nm.parseJSONFromData(data) {
//        
//        let resultDictionaries = jsonDictionary["result"] as! [[String : Any]]
//        for resultsDictionary in resultDictionaries {// enumerate through dictionary
//          let jsonInfo = JSONObject(resultsDictionary: resultsDictionary)
//          
//          jsonDataArray.append(jsonInfo)
//          
//        }
//        print(jsonDataArray.capacity)
//        completion(jsonDataArray)
//
//      }
//    })
//    
//  
//    }
}






