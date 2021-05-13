//
//  ViewController.swift
//  AddToFavList
//
//  Created by Bharani Nammi on 7/27/20.
//  Copyright © 2020 Bharani Nammi. All rights reserved.
//

import UIKit
import CoreLocation

class AddRecipeController: UIViewController {
    
     var finishedRecipe: [FinishedRecipe] = []
     var dataController:DataController = DataController.shared
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.title = Client.importantInfo.title
        
        self.textView.text = Client.importantInfo.instructionLines
        
        
    }
    @IBAction func AddRecipe(_ sender: Any) {
        
       //add the recipe to the core data
        self.add()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func add(){
        
        let finishedRecipe = FinishedRecipe(context: dataController.viewContext)
//        pin.latitude = Flickr.latAndLonAndUrl.latitude
//        pin.longitude = Flickr.latAndLonAndUrl.longitude
        finishedRecipe.instructions = Client.importantInfo.instructionLines
        finishedRecipe.name = Client.importantInfo.title
        
        try? dataController.viewContext.save()
        self.finishedRecipe.append(finishedRecipe)
    }
}

