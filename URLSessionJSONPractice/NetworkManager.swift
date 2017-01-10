//
//  NetworkManager.swift
//  URLSessionJSONPractice
//
//  Created by Justin Doo on 1/7/17.
//  Copyright © 2017 JustinDoo. All rights reserved.
//

import Foundation


class NetworkManager: NSObject {
  
  static let sharedManager = NetworkManager()
  
  private let baseURL = "https://nomadlist.com/api/v2/list"
  
  
  lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
  lazy var session: URLSession = URLSession(configuration: self.configuration)
  
  typealias JSONData = ((Data) -> Void)
  
  
  func getJSONData(urlExtension: String, completion: @escaping JSONData) {
    
    let request = URLRequest(url: URL(string:"\(baseURL)\(urlExtension)")! )
    let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
      
      if error == nil {
        if let httpResponse = response as? HTTPURLResponse {
          switch (httpResponse.statusCode) {
          case 200:
            if let data = data {
              completion(data)
            }
          default:
            print(httpResponse.statusCode)
          }
        }
      } else {
        print("Error: \(error?.localizedDescription)")
      }
    })
    
    dataTask.resume()
    
  }
  

  func parseJSONFromData(_ jsonData: Data?) -> [String : AnyObject]?
  {
    if let data = jsonData {
     
      do {
        let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : AnyObject]//Parses data into a dictionary
        
        return jsonDictionary
        
      } catch let error as NSError {
        print("error processing json data: \(error.localizedDescription)")
      }
    }
    
    return nil
  }

}






















