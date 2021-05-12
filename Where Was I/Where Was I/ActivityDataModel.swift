//
//  ActivityDataModel.swift
//  Where Was I
//
//  Created by Shuangquan on 3/10/21.
// Next to do:
// how to set the UUID. is the UUID init correct?
//

import Foundation
import SwiftUI

class ActivityDataModel{
       /// Format of date and time
    private var formatter: DateFormatter = DateFormatter()
    /// Time stamp of the activity, including date
    private var timeStamp: Date
    ///a sentence to describe the activity
    private var activityDescription: String
    /// location of the activity
    private var location: String
    ///unique ID
    private var uuid: UUID = UUID.init()
    /// optional activity detail. has to be specified by user
    private var activityDetail: String
    //color to identify the activity
    private var tagColor: Color

    
    init(){
        /// current Date, including time.
        self.timeStamp = Date()
        /// date style: Nov 23, 1937
        self.formatter.dateStyle = .medium
        /// time style: 3:30:32 PM
        self.formatter.timeStyle = .medium
        /// empty string
        self.activityDescription = ""
        /// no location specified
        self.location = "N/A"
        self.activityDetail = ""
        self.uuid = UUID()
        self.tagColor = Color.randomColor
    }
    
    /// input parameter: date, activity, location.   Other init method needed?
    init(timeStamp: Date, activityDescription: String, location: String) {
        self.timeStamp = timeStamp
        self.activityDescription = activityDescription
        self.formatter.dateStyle = .medium
        self.formatter.timeStyle = .medium
        self.location = location
        self.activityDetail = ""
        self.uuid = UUID()
        self.tagColor = Color.randomColor
    }
    
    /// input parameter: date, activity, location.   Other init method needed?
    init(timeStamp: Date, activityDescription: String, location: String, activityDetail: String) {
        self.timeStamp = timeStamp
        self.activityDescription = activityDescription
        self.formatter.dateStyle = .medium
        self.formatter.timeStyle = .medium
        self.location = location
        self.activityDetail = activityDetail
        self.uuid = UUID()
        self.tagColor = Color.randomColor
    }
    
    /// input parameter: date, activity, location.   Other init method needed?
    init(timeStamp: Date, activityDescription: String, location: String, activityDetail: String, uuid: UUID) {
        self.timeStamp = timeStamp
        self.activityDescription = activityDescription
        self.formatter.dateStyle = .medium
        self.formatter.timeStyle = .medium
        self.location = location
        self.activityDetail = activityDetail
        self.uuid = uuid
        self.tagColor = Color.randomColor
    }
    
    init(timeStamp: Date, activityDescription: String, location: String, activityDetail: String, uuid: UUID, tagColor: Color) {
        self.timeStamp = timeStamp
        self.activityDescription = activityDescription
        self.formatter.dateStyle = .medium
        self.formatter.timeStyle = .medium
        self.location = location
        self.activityDetail = activityDetail
        self.uuid = uuid
        self.tagColor = tagColor
    }
    
    /// get date time in a string from time stamp
    func getDateTime() -> String {
        return self.formatter.string(from: timeStamp)
    }
    
    /// get the original timeStamp. no converstion to String
    func getTimeInDate() -> Date {
        return self.timeStamp
    }
    
    
    /// get only the time for the activity. This will be used for today's view
    func getTimeOnly() -> String {
        let formatter3 = DateFormatter()
        /// .short is like 09:22 am
        formatter3.timeStyle = .short
        return formatter3.string(from: timeStamp)
    }
    
    func getDateOnly() -> String {
        let formatter4 = DateFormatter()
        /// 2021-04-15 format
        formatter4.dateFormat = "yyyy-MM-dd"
        return formatter4.string(from: timeStamp)
    }
    
    /// set the date and time
    func setDateTime(date:Date){
        self.timeStamp = date
    }
    
    /// get the activity
    func getActivityDescription() -> String {
        return self.activityDescription
    }
    
    /// enter the activity. Do we need update anything?
    func setActivityDescription(activityDescription: String){
        self.activityDescription = activityDescription
    }
    
    /// get location as a string
    func getLocation() -> String {
        return self.location
    }
    
    /// enter the location
    func setLocation(location: String) {
        self.location = location
    }
    
    /// get activity detail
    func getActivityDetail() -> String {
        return self.activityDetail
    }
    
    func setActivityDetail(activityDetail: String) {
        self.activityDetail = activityDetail
    }
    
     func getUUID() -> UUID {
        return self.uuid
    }
    
    func setUUID(uuid: UUID) {
        self.uuid = uuid
    }
    
    public static func visitToADM(v: Visit) -> ActivityDataModel{
        let colorLocationDict = ["Living Room": Color.pink, "Bed Room": Color.yellow, "Kitchen": Color.purple, "Garage": Color.blue, "Bath Room": Color.green]
        let tagC = colorLocationDict[v.locationName] ?? Color.gray
        
        return ActivityDataModel(timeStamp: v.arrivalDate, activityDescription: v.activityDescription, location: v.locationName, activityDetail: v.activityDetail, uuid: v.uuid, tagColor: tagC)
    }
    
}

fileprivate let colorAssortment: [Color] = [.turquoise, .forestGreen, .darkPink, .darkRed, .lightBlue, .salmon, .military]

private extension Color {

    static var randomColor: Color {
        let randomNumber = arc4random_uniform(UInt32(colorAssortment.count))
        return colorAssortment[Int(randomNumber)]
    }

}

private extension Color {

    static let turquoise = Color(red: 24, green: 147, blue: 120)
    static let forestGreen = Color(red: 22, green: 128, blue: 83)
    static let darkPink = Color(red: 179, green: 102, blue: 159)
    static let darkRed = Color(red: 185, green: 22, blue: 77)
    static let lightBlue = Color(red: 72, green: 147, blue: 175)
    static let salmon = Color(red: 219, green: 135, blue: 41)
    static let military = Color(red: 117, green: 142, blue: 41)

}

fileprivate extension Color {

    init(red: Int, green: Int, blue: Int) {
        self.init(red: Double(red)/255, green: Double(green)/255, blue: Double(blue)/255)
    }
    
}
