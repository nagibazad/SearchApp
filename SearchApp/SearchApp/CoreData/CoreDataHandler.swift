//
//  CoreDataHandler.swift
//  SearchApp
//
//  Created by Nagib Azad on 21/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import UIKit
import Foundation
import CoreData

let kDbName = "SearchDataModel.sqlite"
let kResourceName = "SearchDataModel"
let kExtension = "momd"

class CoreDataHandler: NSObject {
    
    static let sharedInstance = CoreDataHandler()
    
    func privateManagedObjectContext() -> NSManagedObjectContext? {
        guard let parentContext = self.mainManagedObjectContext else{
            return nil;
        }
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = parentContext;
        privateContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return privateContext
    }
    
    private lazy var applicationDocumentsDirectory:URL? = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    }()
    
    private lazy var managedObjectModel:NSManagedObjectModel = {
        let modelUrl = Bundle.main.url(forResource: kResourceName, withExtension: kExtension)
        return NSManagedObjectModel(contentsOf: modelUrl!)!;
    }()
    
    private lazy var persistentStoreCoordinator:NSPersistentStoreCoordinator? = {
        let storeUrl = self.applicationDocumentsDirectory?.appendingPathComponent(kDbName);
        
        var storeCoordinator : NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        do {
            try storeCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: [NSMigratePersistentStoresAutomaticallyOption: true,NSInferMappingModelAutomaticallyOption: true])
            
        } catch {
            exit(1);
        }
        return storeCoordinator;
    }()
    
    private lazy var mainManagedObjectContext:NSManagedObjectContext? = {
        
        guard let parentContext = self.masterManagedObjectContext else{
            return nil;
        }
        var mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.parent = parentContext;
        mainContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return mainContext
    }()
    
    fileprivate lazy var masterManagedObjectContext:NSManagedObjectContext? = {
        guard let coordinator = self.persistentStoreCoordinator else{
            return nil
        }
        var masterContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        masterContext.persistentStoreCoordinator = coordinator
        masterContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return masterContext
    }()
    
    class func insertNewManagedObject(forEntityName entityName:String, inManagedObjectContext managedObjectContext:NSManagedObjectContext) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: managedObjectContext)
    }
    
    func saveDataAsynchronusly(inManagedObjectContext managedObjectContext:NSManagedObjectContext, withCompletionHandler completionHandler:((Bool, NSError?)->())?) -> (){
        
        managedObjectContext.saveAsyncRecusively(withCompletionBlock: { (success:Bool, error:NSError?) in
            completionHandler?(success,error)
        })
    }
    
    func saveDataSynchronusly(inManagedObjectContext managedObjectContext:NSManagedObjectContext, withCompletionHandler completionHandler:((Bool, NSError?)->())?) -> (){
        
        managedObjectContext.saveSyncRecusively(withCompletionBlock: { (success:Bool, error:NSError?) in
            completionHandler?(success,error)
        })
    }
    
    func fetchObjectAsynchronusly(withFetchRequest fetchRequest:NSFetchRequest<NSFetchRequestResult>, withCompletionHandler completionHandler:(([NSManagedObject]?, Error?) -> ())?) -> (){
        
        self.mainManagedObjectContext?.perform({
            var fetchedObjects:[NSManagedObject]? = nil
            var error:NSError? = nil
            do{
                try fetchedObjects = self.mainManagedObjectContext?.fetch(fetchRequest) as! [NSManagedObject]?
            }catch let fetchError as NSError{
                error = fetchError
            }
            completionHandler?(fetchedObjects,error)
        })
    }
    
    func fetchObjectSynchronusly(withFetchRequest fetchRequest:NSFetchRequest<NSFetchRequestResult>, withCompletionHandler completionHandler:(([NSManagedObject]?, Error?) -> ())?) -> (){
        
        self.mainManagedObjectContext?.performAndWait({
            var fetchedObjects:[NSManagedObject]? = nil
            var error:NSError? = nil
            do{
                try fetchedObjects = self.mainManagedObjectContext?.fetch(fetchRequest) as! [NSManagedObject]?
            }catch let fetchError as NSError{
                error = fetchError
            }
            completionHandler?(fetchedObjects,error)
        })
    }
    
    
}

