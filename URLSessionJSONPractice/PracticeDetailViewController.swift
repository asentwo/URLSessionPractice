//
//  PracticeDetailViewController.swift
//  URLSessionJSONPractice
//
//  Created by Justin Doo on 1/7/17.
//  Copyright © 2017 JustinDoo. All rights reserved.
//

import Foundation
import UIKit


class PracticeDetailViewController: UIViewController {
  
  var jsonObjectArray: [JSONObject] = []
  
  
  @IBOutlet weak var topLabel: UILabel!
  @IBOutlet weak var bottomLabel: UILabel!
  @IBOutlet weak var image: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    DispatchQueue.main.async {
      self.topLabel.text = String(self.jsonObjectArray[0].airbnbUS)
     self.bottomLabel.text = String(self.jsonObjectArray[0].airbnbLocal)
    }

    
    do {
     let data = try Data(contentsOf: jsonObjectArray[0].image)
     
         DispatchQueue.main.async(execute: { //Update image on main queue
          self.image.image = UIImage(data: data)
     })
      
    } catch {}
  
  }
}
