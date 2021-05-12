//
//  ActivityDetail.swift
//  Where Was I
//
//  Created by Hao Jiang on 3/16/21.
//

import SwiftUI

struct ActivityDetail: View {
    var activityDataModel: ActivityDataModel
//    @State var detail: String = "init value"
    
    var body: some View {
        // remove navigation view.
        NavigationView {
            VStack() {
                Text(activityDataModel.getActivityDetail())
                    .font(.title)
                Spacer()
//                Text(detail)
//                    .font(.title)
                EditDetailButton(activityDataModel: activityDataModel)
                Spacer()
            }
        }
        
    }
}


struct EditDetailButton: View {
    @State var showingSheet = false
    let activityDataModel: ActivityDataModel

    var body: some View{
        Button{
            showingSheet.toggle()
        } label: {
            Text("Edit detail")
                .frame(minWidth: 0, maxWidth: 300)
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.red]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
                .font(.title)
            
        }
        .sheet(isPresented: $showingSheet, content: {
            EditActivityDetail(activityDataModel: activityDataModel)
        })
    }
}


struct ActivityDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetail(activityDataModel: ActivityDataModel())
    }
}
