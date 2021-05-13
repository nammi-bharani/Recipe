//
//  AddedList.swift
//  AddToFavList
//
//  Created by Bharani Nammi on 7/28/20.
//  Copyright © 2020 Bharani Nammi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddedList:  UITableViewController {
    
    var finishedRecipe: [FinishedRecipe] = []
    var selectedIndex = 0
    var dataController:DataController!
    
    override func viewDidLoad() {
        
        //only needed once
//        let fetchRequest:NSFetchRequest<FinishedRecipe> = FinishedRecipe.fetchRequest()
//                      if let result = try? dataController.viewContext.fetch(fetchRequest){
//                        finishedRecipe = result
//                      }

    }
    
    override func viewWillAppear(_ animated: Bool) {
           
        super.viewWillAppear(animated)

        let fetchRequest:NSFetchRequest<FinishedRecipe> = FinishedRecipe.fetchRequest()
                          if let result = try? dataController.viewContext.fetch(fetchRequest){
                            finishedRecipe = result
                          }

        tableView.reloadData()
        
       }
    
    @IBAction func FindLocation(_ sender: Any) {
        
        Client.getRandomRecipe { (recipe, error) in
            
            for i in recipe{
                
                print(i.title)
                Client.importantInfo.title = i.title
                Client.importantInfo.instructionLines = i.instructions
                print(i.instructions)
                
                self.performSegue(withIdentifier: "RandomRecipe", sender: nil)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("printing the count: \(finishedRecipe.count)")
        //print(StudentLocationModel.result.count)
        return finishedRecipe.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let result = finishedRecipe[indexPath.row]
        

        cell.textLabel?.text = result.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "DetailView" {
           if let viewController = segue.destination as? TableViewDetailViewController {
            viewController.finishedRecipe = finishedRecipe[selectedIndex]
           }
       }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.performSegue(withIdentifier: "DetailView", sender: nil)
    }
    
    
}
