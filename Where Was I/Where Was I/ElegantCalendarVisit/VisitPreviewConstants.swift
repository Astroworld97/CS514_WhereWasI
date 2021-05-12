// Kevin Li - 6:06 PM - 6/13/20

import SwiftUI

struct VisitPreviewConstants {
    @Environment(\.sizeCategory) var sizeCategory
    static var cellHeight: CGFloat = 100
    static let cellPadding: CGFloat = 10
    //private var f: CGFloat
    static let previewTime: TimeInterval = 3
    
    public static func getCellHeight() -> CGFloat{
        return VisitPreviewConstants.cellHeight
    }
    
    public static func setCellHeight(cellHeight: CGFloat){
        VisitPreviewConstants.cellHeight = cellHeight
    }
    

}

