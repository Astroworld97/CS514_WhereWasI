//
//  DataModel.swift
//  Where Was I
//
//  Created by Biswas, Ananda [LAS] on 4/11/21.
//

import Foundation
import CoreData

extension Activity{
    
    /// take in a whole activityDataModel, and add to local db
    static func addAct(viewContext: NSManagedObjectContext, activityDataModel: ActivityDataModel) {
        let newAct = Activity(context: viewContext)
        newAct.actDescription = activityDataModel.getActivityDescription()
        newAct.day = activityDataModel.getDateOnly()
        newAct.time = activityDataModel.getTimeInDate()
        newAct.location = activityDataModel.getLocation()
        newAct.actDetail = activityDataModel.getActivityDetail()
        newAct.uuid = activityDataModel.getUUID()
        
        save(viewContext: viewContext)
        print("Added")
    }
    
    /// get all items from local db. Need to test on it.
    static func getAllAct(viewContext: NSManagedObjectContext) -> [Activity]{
        
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        
        /// try to fetch all without any filtering
        do{
            let activities = try viewContext.fetch(fetchRequest)
            return activities
            
        } catch {
            print("fetch for a given day error \(error )")
            return []
        }
    }
    
    
    static func actToActDataModel(a: Activity) -> ActivityDataModel{
        let adm = ActivityDataModel()
        adm.setLocation(location: a.location ?? "")
        adm.setDateTime(date: a.time ?? Date())
        adm.setActivityDescription(activityDescription: a.actDescription ?? "")
        adm.setUUID(uuid: a.uuid!)
        adm.setActivityDetail(activityDetail: a.actDetail ?? "")
        return adm
    }
    
    static func actArrToADMArr(a: [Activity]) -> [ActivityDataModel]{
        var admArr = [ActivityDataModel]()
        
        a.forEach{ act in
            let toAdd = Activity.actToActDataModel(a: act)
            admArr.append(toAdd)
        }
        return admArr
    }
    
    /// fetch the activities for a given date.
    /// take a specific date as input, use it to search local db, and fetch a list of activities
    /// Only compare with the day: String
    static func getActsByDate (viewContext: NSManagedObjectContext, thatDay: Date)-> [Activity] {
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        /// get the 2021-05-10 like format string to compare with local db day:String field
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let thatDayString: String = formatter.string(from: thatDay)
        fetchRequest.predicate = NSPredicate(format: "day == %@", thatDayString)
        
        do{
            let activities = try viewContext.fetch(fetchRequest)
            return activities
            
        } catch {
            print("fetch for a given day error \(error )")
            return []
        }
    }
    
    /// fetch one activity from localdb. will find it by uuid
    static func getActbyUUID (viewContext: NSManagedObjectContext, _currDesc: String)-> Activity {
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        fetchRequest.predicate = NSPredicate(format: "actDescription = %@", _currDesc)
        
       
        let activities = try? viewContext.fetch(fetchRequest)
        // what should be the default return type for this?
        let act = activities?.first ?? Activity()
        return act
    }
    
    /// update an existing activity. will find it by uuid
        static func updateActUUID(viewContext: NSManagedObjectContext, _uuid: UUID, activityDataModel: ActivityDataModel) {
            
            let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
            fetchRequest.predicate = NSPredicate(format: "uuid = %@", _uuid as CVarArg)
          
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let activities = try? viewContext.fetch(fetchRequest)
            
            if let act = activities?.first {
                act.actDescription = activityDataModel.getActivityDescription()
                act.actDetail = activityDataModel.getActivityDetail()
                act.location = activityDataModel.getLocation()
                act.time = activityDataModel.getTimeInDate()
                save(viewContext: viewContext)
            }
            print("Updated activity")
        }
    
    /// update an existing activity's detail only. '
    static func updateActDetailUUID(viewContext: NSManagedObjectContext, _uuid: UUID, actDetail: String) {
            
            let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
            fetchRequest.predicate = NSPredicate(format: "uuid = %@", _uuid as CVarArg)
                      
            let activities = try? viewContext.fetch(fetchRequest)
            
            if let act = activities?.first {
                act.actDetail = actDetail
                save(viewContext: viewContext)
            }
            print("Updated activity")
        }
        
        /// delete the activity based on UUID
        static func delActUUID(viewContext: NSManagedObjectContext, _uuid: UUID){
            
            let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
            fetchRequest.predicate = NSPredicate(format: "uuid = %@", _uuid as CVarArg)
            
            if let result = try? viewContext.fetch(fetchRequest){
                for object in result{
                    viewContext.delete(object)
                }
            }
            save(viewContext: viewContext)
        }
        
    /// save to local db
    private static func save(viewContext: NSManagedObjectContext){
        do {
            try viewContext.save()
            print("Saved activity")

        }catch{
            let error = error as NSError
            fatalError("Unable to save: \(error)")
        }
    }
}
