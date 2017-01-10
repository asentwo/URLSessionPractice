//
//  ViewController.swift
//  URLSessionJSONPractice
//
//  Created by Justin Doo on 1/7/17.
//  Copyright © 2017 JustinDoo. All rights reserved.
//

import UIKit

class PracticeTableViewController: UITableViewController {
  
  var jsonObjectsArray: [JSONObject] = []
  
  @IBOutlet var practiceTableView: UITableView!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    JSONObject.updateResultsDictionary(urlExtension: "/cities/basel-switzerland", completion: { results in
      
      guard let results = results else {
      
        print("There was an error retrieving info")
        
        return
      }
      
      self.jsonObjectsArray.append(results)
      
      DispatchQueue.main.async {
        self.practiceTableView.reloadData()
      }
    })
    
  }
  
  
  
  //MARK: TableView
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = practiceTableView.dequeueReusableCell(withIdentifier:  "practiceTableViewCell", for: indexPath) as! PracticeTableViewCell
    
    let jsonData = jsonObjectsArray[indexPath.row]
    
    cell.jsonObject = jsonData
    
    return cell
  }
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return jsonObjectsArray.count
  }
  
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    performSegue(withIdentifier: "practiceTableToDetailSegue", sender: self)
  }
  
  
  
  //MARK: Segue
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "practiceTableToDetailSegue" {
      
      if let detailVC = segue.destination as? PracticeDetailViewController {
        
         detailVC.jsonObjectArray = self.jsonObjectsArray
        
      }
    }
  }
}
