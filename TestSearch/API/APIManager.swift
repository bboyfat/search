//
//  APIManager.swift
//  TestSearch
//
//  Created by Andrey Petrovskiy on 6/20/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import CoreData

enum SortType{
    case stars
    case alphabet
}



class APIManager{

    func getData(with sort: SortType, with query: String, handler: @escaping (Bool) -> ()){
        
        let urlWithComponents: String = {
            switch sort{
            case.alphabet:
                return "https://api.github.com/search/repositories?q=\(query)+language:assembly&order=desc"
            case.stars:
                return"https://api.github.com/search/repositories?q=\(query)+language:assembly&sort=stars&order=desc"
            }
            
        }()
//        let urlString = "https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc"
        guard let url = URL(string: urlWithComponents) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print("We have an error", error)
                handler(false)
                return
            }
            if let data = data{
                do{
                    let answer = try JSONDecoder().decode(APIModel.self, from: data)
                    handler(true)
                    answer.items.forEach({ (item) in
                        
                        let context = CoreDataSingleton.shared.persistantContainer.viewContext
                        
                        let repo = NSEntityDescription.insertNewObject(forEntityName: "Repo", into: context)
                        
                        repo.setValue(item.name, forKey: "name")
                        repo.setValue(item.html_url, forKey: "link")
                        repo.setValue(item.stargazers_count, forKey: "stars")
                        if let url = URL(string: item.owner.avatar_url) {
                            let data = try? Data(contentsOf: url)
                            if let data = data {
                                repo.setValue(data, forKey: "avatar")
                            }
                        }
                        
                        do{
                            try context.save()
                            
                        } catch let sevErr{
                            print("Failed to save company \(sevErr)")
                        }
                    })
                    
                    
                } catch let decErr{
                    print("Problem with decoding", decErr)
                }
            }
            }.resume()
    }
    
   
    
}
