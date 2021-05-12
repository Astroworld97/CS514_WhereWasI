//
//  DataManager.swift
//  Where Was I
//
//  Created by Biswas, Ananda [LAS] on 3/27/21.
//


import Foundation
import CoreData

public extension NSManagedObject {

    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }

}

class DataManager{
    let persistentContainer: NSPersistentContainer
    
    init(){
      
      persistentContainer = NSPersistentContainer(name: "DataModel")
      persistentContainer.loadPersistentStores { description, error in
        if let error = error as NSError? {
          // Handle error
          fatalError("Error:MainView:loadPersistentContainer \(error), \(error.userInfo)")
        }
      }
    }

    
    //save to database
    func saveActivity(actName: String, actDesc: String, distance: Int64, major: Int64, minor: Int64, time: Date, uuid: String ) {
        let act = Activity(context: persistentContainer.viewContext)
        act.actName = actName
        act.actDescription = actDesc
        act.distance = distance
        act.major = major
        act.minor = minor
        act.time = time
        act.uuid = uuid
        
        do{
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save Location \(error)")
        }
    }
    
    func saveAct(actName: String, actDesc: String, distance: Int64, major: Int64, minor: Int64) {
        let act = Activity(context: persistentContainer.viewContext)
        act.actName = actName
        act.actDescription = actDesc
        act.distance = distance
        act.major = major
        act.minor = minor
        
        do{
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save Location \(error)")
        }
    }
    
    func getActivity() -> [Activity] {
        let fetchRequest: NSFetchRequest<Activity>  = Activity.fetchRequest()
        
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
            
        } catch {
            print("fetch location error \(error )")
            return []
        }
    }
    
    
}

