//
//  DataManager.swift
//  EightBallApp
//
//  Created by Aleksandr Moroshovskyi on 9/2/19.
//  Copyright © 2019 Aleksandr Moroshovskyi. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {
    class func fetchData<T: NSManagedObject>(type: T.Type) -> (array: [T]?, error: NSError?) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let result = try context.fetch(type.fetchRequest())
            return (result as? [T], nil)
        } catch let error as NSError {
            print("Could not save \(error)", error.userInfo)
            return (nil, error)
        }
    }
    
    class func saveData<T: NSManagedObject>(type: T.Type, forKey key: String, value: String) -> (entity: T?, error: NSError?) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = type.init(entity: type.entity(), insertInto: context)
        entity.setValue(value, forKey: key)
        
        do {
            try context.save()
            return (entity, nil)
        } catch let error as NSError {
            return (nil, error)
        }
    }
    
    class func deleteData(object: NSManagedObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(object)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}
