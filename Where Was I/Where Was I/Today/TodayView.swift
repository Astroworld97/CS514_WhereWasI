//
//  TodayView.swift
//  Where Was I
//
//  Created by Shuangquan Li on 3/3/21.
//

// Next Step:
// add a button for manual adding activity
// fix the ugly UI of update activity details
// work on the history view.

import SwiftUI
import UserNotifications


struct TodayView: View {
    @Environment(\.sizeCategory) var sizeCategory
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var detector = BeaconDetector()
        
    /// Need to fetch the activities of today, and sort by timestamp
    @FetchRequest(
        entity: Activity.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Activity.time, ascending: false)
        ],
        predicate: NSPredicate(format: "day == %@", Utility().getToday()) // hardcoded. Need to convert Date() to 2021-04-15 format
    )
    private var activities: FetchedResults<Activity>
    

    var body: some View {
//        let activityDescrption : String = "Cook for dinner"
//        let loc : String = "Kitchen"
//        let persistenceContainer = PersistenceController.shared
        
        
        NavigationView{
            List{
//                /// temp for hardcoded display
//                NavigationLink(destination: ActivityDetail(activityDataModel: ActivityDataModel())) {
//                    ActivityRow(activityDataModel: ActivityDataModel(timeStamp: Date(), activityDescription: activityDescrption, location: loc))
//                }
                /// real list view to display each activity in a row
                /// use the fetched activities, for each activity, create a new activity datamodel, and use it as the input for ActivityDetail and ActivityRow
                ForEach(activities) { activity in
                    let oneActivityDataModel = ActivityDataModel(
                        timeStamp: activity.time ?? Date(),
                        activityDescription: activity.actDescription ?? "",
                        location: activity.location ?? "N/A",
                        activityDetail: activity.actDetail ?? "",
                        uuid: activity.uuid!
                    )
//                    oneActivityDataModel.uuid = activity.uuid!
                    NavigationLink(destination: ActivityDetail(activityDataModel: oneActivityDataModel)) {
                        ActivityRow(activityDataModel: oneActivityDataModel)
                    }
                }
                .onDelete(perform: removeRows)
            }
            .navigationTitle("Today")
            .toolbar(content: {
                AddButton()
            })
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    // need to pass the uuid to delete from the local db
    func removeRows(at offsets: IndexSet) {
        let index = offsets.map({$0 * 1})
//        print(activities[index.first!].uuid)
//        print(activities[index.first!].actDescription)
//        print(activities[index.first!].time)
        
        /// need to call delete by UUID
        Activity.delActUUID(viewContext: viewContext, _uuid: activities[index.first!].uuid!)
    }
}

struct AddButton: View {
    @State var showingSheet = false

    var body: some View{
        Button{
            showingSheet.toggle()
        } label: {
            Image(systemName: "plus.circle")
            
        }
        .sheet(isPresented: $showingSheet, content: {
            AddActivityView()
        })
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
