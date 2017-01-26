//
//  PracticeTableViewCell.swift
//  URLSessionJSONPractice
//
//  Created by Justin Doo on 1/7/17.
//  Copyright © 2017 JustinDoo. All rights reserved.
//

import Foundation
import UIKit




class PracticeTableViewCell: UITableViewCell {
  
  
  @IBOutlet weak var leftLabel: UILabel!
  @IBOutlet weak var rightLabel: UILabel!
  @IBOutlet weak var cellImage: UIImageView!

  let nm = NetworkManager.sharedManager
  
  var jsonObject: JSONObject! {
    didSet {
      self.updateUI()
    }
  }
  
  func updateUI () {
    
  self.leftLabel.text = String(jsonObject.airbnbUS)
   self.rightLabel.text = String(jsonObject.airbnbLocal)
   
   do {
    
     let data = try Data(contentsOf: jsonObject.image)
    
     DispatchQueue.main.async(execute: { //Update image on main queue
       self.cellImage.image = UIImage(data: data)
     })
    
   } catch {}
  }
}
