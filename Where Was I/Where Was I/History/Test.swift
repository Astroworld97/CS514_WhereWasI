//
//  Test.swift
//  Where Was I
//
//  Created by Ian Gonzalez on 4/22/21.
//

import Foundation
import SwiftUI
import ElegantCalendar

struct Test{
    @Environment(\.managedObjectContext) var viewContext
    var listVisits: [Visit] = []
    var listActivities: [ActivityDataModel] = []
    var act1: ActivityDataModel
    var act2: ActivityDataModel
    var act3: ActivityDataModel
    var act4: ActivityDataModel
    var act5: ActivityDataModel
    var act6: ActivityDataModel
    var v1: Visit
    var v2: Visit
    var v3: Visit
    var v4: Visit
    var v5: Visit
    var v6: Visit
    let now: Date
    let oneMonthAgo: Int
    let oneMonthFuture: Int
    let oneMonthAgoPlusDay: Int
    var act1Time: Date
    var act3Time: Date
    //public var e: ExampleCalendarView
    
    public init(){
        act1 = ActivityDataModel()
        act2 = ActivityDataModel()
        act3 = ActivityDataModel()
        act4 = ActivityDataModel()
        act5 = ActivityDataModel()
        act6 = ActivityDataModel()
        
        act1.setLocation(location: "Kitchen")
        act2.setLocation(location: "Bathroom")
        act3.setLocation(location: "Bedroom")
        act4.setLocation(location: "Balcony")
        act5.setLocation(location: "Living Room")
        act6.setLocation(location: "Garage")
        now = Date()
        oneMonthAgoPlusDay = 60 * 60 * 24 * -31
        oneMonthAgo = 60 * 60 * 24 * -30
        oneMonthFuture = 60 * 60 * 24 * 30
        act1Time = Date().addingTimeInterval(TimeInterval(oneMonthAgo))
        act3Time = Date().addingTimeInterval(TimeInterval(oneMonthFuture))
        act1.setDateTime(date: act1Time)
        act2.setDateTime(date: now)
        act3.setDateTime(date: act3Time)
        act4.setDateTime(date: now)
        act5.setDateTime(date: act3Time)
        act6.setDateTime(date: Visit.dateADayFromNow())
        
        listActivities.append(act1)
        listActivities.append(act2)
        listActivities.append(act3)
        listActivities.append(act4)
        listActivities.append(act5)
        listActivities.append(act6)
        
        v1 = Visit.withData(data: act1)
        v2 = Visit.withData(data: act2)
        v3 = Visit.withData(data: act3)
        v4 = Visit.withData(data: act4)
        v5 = Visit.withData(data: act5)
        v6 = Visit.withData(data: act6)
        
        listVisits.append(v1)
        listVisits.append(v2)
        listVisits.append(v3)
        listVisits.append(v4)
        listVisits.append(v5)
        listVisits.append(v6)
        
        //this forEach loop converts all visits into ActivityDataModels and adds them into the database using the Activity.addAct() function
        
        listActivities.forEach{ act in
            Activity.addAct(viewContext: viewContext, activityDataModel: act)
        }
        
//        listVisits.forEach{ visit in
//            let toAdd = ActivityDataModel.visitToADM(v: visit)
//            Activity.addAct(viewContext: viewContext, activityDataModel: toAdd)
//        }
        
//        e = ExampleCalendarView(ascVisits: listVisits, initialMonth: Date())
    }
    
//    public func printVisitsByDay(){
//        print(e.visitsByDay)
//    }
    
//    public static func activityPrintVisitsByDay(thatDay: Date){
//        print(Activity.getActsByDate(viewContext: HistoryView.viewContext, thatDay: Date()))
//    }
    
    public func addAllVisitsOneDay(thatDay: Date) -> [Activity]{
        return Activity.getActsByDate(viewContext: viewContext, thatDay: thatDay)
    }
    
//    public func getE() -> ExampleCalendarView{
//        return e;
//    }
    
}



