// Kevin Li - 4:30 PM - 6/13/20

import SwiftUI
import Foundation

struct VisitCell: View {
    @Environment(\.sizeCategory) var sizeCategory
    let visit: Visit
    @State var size: Bool = true

    var body: some View {
    
        HStack {
            tagView

            VStack(alignment: .leading) {
                locationName
//                visitDuration
                visitStartTime
            }
            Spacer()
            activityDesc
            Spacer()
            
        }.onAppear(){
            size = sizeCategory.isAccessibilityCategory
            if sizeCategory.isAccessibilityCategory{
                VisitPreviewConstants.setCellHeight(cellHeight: 100.0)
            }else{
                VisitPreviewConstants.setCellHeight(cellHeight: 30.0)
            }
        }.onDisappear(){
            size = sizeCategory.isAccessibilityCategory
            if sizeCategory.isAccessibilityCategory{
                VisitPreviewConstants.setCellHeight(cellHeight: 100.0)
            }else{
                VisitPreviewConstants.setCellHeight(cellHeight: 30.0)
            }
        }
        .frame(height: VisitPreviewConstants.cellHeight)
        .padding(.vertical, VisitPreviewConstants.cellPadding)
    }

}

private extension VisitCell {

    var tagView: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(visit.tagColor)
            .frame(width: 5, height: 50)
    }

    var locationName: some View {
        Text(visit.locationName)
//            .font(.system(size: 20))
            .font(.body)
            .lineLimit(10)
    }

//    var visitDuration: some View {
//        Text(visit.duration)
//            .font(.system(size: 10))
//            .lineLimit(1)
//    }
    
    /// only display the start time, instead of duration
    var visitStartTime : some View {
//        let formatter : DateFormatter = DateFormatter()
        Text(visit.arrivalDate, style: .time)
            .font(.body) // change font size to system defined size.
            .lineLimit(10)
    }
    
    var activityDesc: some View {
        Text(visit.activityDescription)
            .font(.body)
            .lineLimit(10)
            .padding()
    }
    
//    public static func determineSize(){
//        if (sizeCategory.isAccessibilityCategory) {
//            VisitPreviewConstants.setCellHeight(cellHeight: 100.0)
//        }else{
//            VisitPreviewConstants.setCellHeight(cellHeight: 30.0)
//        }
//    }

}

//struct VisitCell_Previews: PreviewProvider {
//    static var previews: some View {
//        VisitCell(visit: .mock(withDate: Date()), f: <#CGFloat#>)
//
////        DarkThemePreview {
////            VisitCell(visit: .mock(withDate: Date()))
////        }
//    }
//}

