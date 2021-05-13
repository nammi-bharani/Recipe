//
//  TableViewDetailViewController.swift
//  AddToFavList
//
//  Created by Bharani Nammi on 7/28/20.
//  Copyright © 2020 Bharani Nammi. All rights reserved.
//

import Foundation
import UIKit

class TableViewDetailViewController: UIViewController{
    
    
    var finishedRecipe: FinishedRecipe!

    var dataController:DataController = DataController.shared

    @IBOutlet weak var textView: UITextView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = finishedRecipe.name
        self.textView.text = finishedRecipe.instructions
    }
    
}
