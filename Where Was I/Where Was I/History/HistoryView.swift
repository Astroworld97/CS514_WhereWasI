//
//  HistoryView.swift
//  Where Was I
//
//  Created by Shuangquan Li on 3/3/21.
//

import SwiftUI
import ElegantCalendar


struct HistoryView: View {
    @Environment(\.sizeCategory) var sizeCategory
    @Environment(\.managedObjectContext) var viewContext
    @State var actArr: [Activity] = []
    @State var ADMArr: [ActivityDataModel] = []
    @State var visitArr:[Visit] = []
    var body: some View {
        //let t = Test()
//        let actArr = Activity.getActsByDate(viewContext: viewContext, thatDay: Date())
         
        
  //      VStack{
//        NavigationView{
//            Text("history none")
//            .navigationTitle("History")
//        }.navigationViewStyle(StackNavigationViewStyle())
            // example. Now we are displaying up to two months early
            /// in order to run real data. for ascVisits: need a new method to provide [Visit]
        
        ExampleCalendarView(ascVisits: visitArr, initialMonth: Date())
            .onAppear(){
                actArr =  Activity.getAllAct(viewContext: viewContext)
                ADMArr = Activity.actArrToADMArr(a: actArr)
                visitArr = Visit.ADMArrToVisitArr(ADMArr: ADMArr)
            }
            
            
    
        
//        ExampleCalendarView(ascVisits: Visit.mocks(start: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (-30 * 2))), end: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (30 * 0)))), initialMonth: Date())
//        }
    }
}
