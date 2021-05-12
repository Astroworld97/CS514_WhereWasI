//
//  ActivityRow.swift
//  Where Was I
//
//  Created by Hao Jiang on 3/11/21.
//

import SwiftUI

struct ActivityRow: View {
    @Environment(\.sizeCategory) var sizeCategory
    var activityDataModel: ActivityDataModel
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
//        HStack {
//            Text(activityDataModel.getTimeOnly())
//                .bold()
//            Spacer()
//            Text(activityDataModel.getLocation())
//            Spacer()
//            Text(activityDataModel.getActivityDescription())
//            Spacer()
//        }
        VisitCell(visit: .withData(data: activityDataModel))
    }
}

struct ActivityRow_Previews: PreviewProvider {
    static var previews: some View {
        let activityDescrption : String = "Cook for dinner"
        let loc : String = "Kitchen"
        
        ActivityRow(activityDataModel: ActivityDataModel(timeStamp: Date(), activityDescription: activityDescrption, location: loc))
            .previewLayout(.fixed(width: 500, height: 70))
            .font(.body)
    }
}
