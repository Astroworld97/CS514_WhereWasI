//
//  EditActivityDetail.swift
//  Where Was I
//
//  Created by Hao Jiang on 4/17/21.
//

import SwiftUI

struct EditActivityDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    var activityDataModel: ActivityDataModel
    
    var body: some View {
        Form{
            Section(header: Text("Detail")){
                TextField("Enter your activity detail", text: $name)
                
            }
            HStack{
                Spacer()
                saveButton
                Spacer()
            }
            
        }
        
    }
    
    
    var saveButton: some View {
        Button("Save"){
            Activity.updateActDetailUUID(viewContext: viewContext, _uuid: activityDataModel.getUUID(), actDetail: name)
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct EditActivityDetail_Previews: PreviewProvider {
//    var oneActDataModel : ActivityDataModel = ActivityDataModel()
    
    static var previews: some View {
        EditActivityDetail(activityDataModel: ActivityDataModel())
    }
}
