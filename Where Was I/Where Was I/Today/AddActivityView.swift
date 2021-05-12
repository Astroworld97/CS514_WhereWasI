//
//  AddActivityView.swift
//  Where Was I
//
//  Created by Hao Jiang on 4/22/21.
//

import SwiftUI

struct AddActivityView: View {
    @ObservedObject private var act = actDataSimple()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView{
            Form{
                Section(header: Text("Location:")){
                    TextField("Enter location", text: $act.actLocation)
                }
                
                Section(header: Text("Activity:")){
                    TextField("Enter an activity", text: $act.actDescription)
                }
                
                Section(header: Text("")){
                    TextField("More details of the activity", text: $act.actDetail)
                }
                
                HStack{
                    Spacer()
                    Button("Save") {
                        act.saveManual()
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

class actDataSimple: ObservableObject {
    let persistenceContainer = PersistenceController.shared
    var actLocation: String = ""
    var actDescription: String = ""
    var actDetail: String = ""
    
    func saveManual() {
        print("saveManual method called.")
        let newAct = ActivityDataModel()
        newAct.setDateTime(date: Date())
        newAct.setLocation(location: actLocation)
        newAct.setActivityDescription(activityDescription: actDescription)
        newAct.setActivityDetail(activityDetail: actDetail)
        
        Activity.addAct(viewContext: persistenceContainer.container.viewContext, activityDataModel: newAct)
    }
}


struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView()
    }
}
