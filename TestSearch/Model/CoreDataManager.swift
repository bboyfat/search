//
//  CoreDataManager.swift
//  TestSearch
//
//  Created by Andrey Petrovskiy on 6/20/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
import CoreData

class CoreDataSingleton{
    static let shared = CoreDataSingleton()
    
    let persistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TestSearch")
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error{
                fatalError("Loading failed: \(error)")
            }
        })
        
        return container
    }()
    
    func saveData(item: Items){
        let context = CoreDataSingleton.shared.persistantContainer.viewContext
        
        let repo = NSEntityDescription.insertNewObject(forEntityName: "Repo", into: context)
        
            repo.setValue(item.name, forKey: "name")
            repo.setValue(item.html_url, forKey: "link")
        do{
            try context.save()
            
        } catch let sevErr{
            print("Failed to save company \(sevErr)")
        }
    }
    
    func fetchData() -> [Repo]{
        let context = CoreDataSingleton.shared.persistantContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Repo>(entityName: "Repo")
        var repositores: [Repo] = []
        do{
            
            let repositories =  try context.fetch(fetchRequest)
            repositores = repositories
            repositories.forEach { (repo) in
                print(repo.name ?? "")}
           
        } catch let fetchErr{
            
            print("Failed to fetch \(fetchErr)")
        }
        
        return repositores
    }
    
    
}
