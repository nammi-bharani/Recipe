//
//  TripAdvisor.swift
//  AddToFavList
//
//  Created by Bharani Nammi on 7/27/20.
//  Copyright © 2020 Bharani Nammi. All rights reserved.
//

import Foundation
import UIKit

class Client{
    
    struct api {
        static let api_key = "c98dec7cbf8c4662807375e9e352e414"
    }
    
    
     struct importantInfo {
        static var title: String = ""
        static var instructionLines:String = ""
         
         //static var fullUrl = ""
     }
     
     enum Endpoints {
        
         static let base = "https://api.spoonacular.com/recipes/random?apiKey="
         
         case getPart1
                 
         var stringValue: String {
             switch self {
             
             case .getPart1:
                return Client.Endpoints.base+Client.api.api_key
                 
                 
             }
         }
         var url: URL {
             return URL(string: stringValue)!
         }
     }
     class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
         let task = URLSession.shared.dataTask(with: url) { data, response, error in
             guard let data = data else {
                 DispatchQueue.main.async {
                     completion(nil, error)
                 }
                 return
             }
             let decoder = JSONDecoder()
             do {
                 let responseObject = try decoder.decode(ResponseType.self, from: data)
                 //print(responseObject)
                 DispatchQueue.main.async {
                     completion(responseObject, nil)
                 }
             } catch {
                  
                     DispatchQueue.main.async {
                         completion(nil, error)
                     }
             }
         }
         task.resume()
         
         return task
     }
    
    class func getRandomRecipe(completion: @escaping ([Recipe], Error?) -> Void){
        
        taskForGETRequest(url: Client.Endpoints.getPart1.url , responseType: Response.self) { response, error in
            if let response = response {
                print(response.recipes.count)
                completion(response.recipes, nil)
            } else {
                completion([], error)
            }
        }
    }
}
