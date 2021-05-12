//
//  Visit.swift
//  Where Was I
//
//  Created by Ian Gonzalez on 3/24/21.
//

import SwiftUI

let currentCalendar = Calendar.current
let screen = UIScreen.main.bounds

struct Visit {

    public var locationName: String
    public var tagColor: Color
    public var arrivalDate: Date
    public var departureDate: Date
    public var activityDescription: String
    public var activityDetail: String
    public var uuid: UUID
    

//    var duration: String {
//        String(arrivalDate.timeIntervalSinceNow) + " ➝ " + String(departureDate.timeIntervalSinceNow)
//    }
    
    public init(){
        self.locationName = ""
        self.tagColor = Color.randomColor
        self.arrivalDate = Date()
        self.departureDate = Date()
        self.activityDescription = ""
        self.activityDetail = ""
        self.uuid = UUID()
        
    }
    
    public init(locationName: String, tagColor: Color, arrivalDate: Date, departureDate: Date, activityDescription: String, activityDetail: String){
        self.locationName = locationName
        self.tagColor = tagColor
        self.arrivalDate = arrivalDate
        self.departureDate = arrivalDate
        self.activityDescription = activityDescription
        self.activityDetail = activityDetail
        self.uuid = UUID()
    }
    
    public static func dateADayFromNow() -> Date{
        return Date().addingTimeInterval(TimeInterval(60*60*24))
    }
    
    public static func dateADayAgo() -> Date{
        return Date().addingTimeInterval(TimeInterval(60 * 60 * -24))
    }
    
    public static func dateAWeekFromNow() -> Date{
        return Date().addingTimeInterval(TimeInterval(60*60*24*7))
    }
    
    public static func dateAWeekAgo() -> Date{
        return Date().addingTimeInterval(TimeInterval(60*60*24 * -7))
    }
    
    public static func date30DaysFromNow() -> Date{
        return Date().addingTimeInterval(TimeInterval(60*60*24*30))
    }
    
    public static func date30DaysAgo() -> Date{
        return Date().addingTimeInterval(TimeInterval(60*60*24 * -30))
    }
    
}

extension Visit: Identifiable {

    var id: Int {
        UUID().hashValue
    }

}

extension Visit {

    public static func mock(withDate date: Date) -> Visit {
        Visit(locationName: "Living Room",
              tagColor: Color.randomColor,
              arrivalDate: date,
              departureDate: date,
              activityDescription: "Watch TV", activityDetail: "Watching my favorite TV show!")
    }
    
    /// Init a visit with our data model.
    /// Need to specify color based on location
    public static func withData(data : ActivityDataModel) -> Visit {
//        var tagColor = Color.gray
        let colorLocationDict = ["Living Room": Color.pink, "Bed Room": Color.yellow, "Kitchen": Color.purple, "Garage": Color.blue, "Bath Room": Color.green]
        let tagColor = colorLocationDict[data.getLocation()] ?? Color.gray
        
        return Visit(locationName: data.getLocation(),
              tagColor: tagColor,
              arrivalDate: data.getTimeInDate(),
              departureDate: data.getTimeInDate(),
              activityDescription: data.getActivityDescription(), activityDetail: data.getActivityDetail())
        
    }
    
    public static func ADMArrToVisitArr(ADMArr: [ActivityDataModel]) -> [Visit]{
        var visitArr = [Visit]()
        
        ADMArr.forEach{ adm in
            let toAdd = Visit.withData(data: adm)
            visitArr.append(toAdd)
        }
        return visitArr
    }

    public static func mocks(start: Date, end: Date) -> [Visit] {
        currentCalendar.generateVisits(
            start: start,
            end: end)
    }
    
    /// with fetched data for a particular day to display
//    public static func withDatas() -> [Visit] {
//
//    }

}

fileprivate let visitCountRange = 1...20

private extension Calendar {

    func generateVisits(start: Date, end: Date) -> [Visit] {
        var visits = [Visit]()
        
        // fake some data
        let activityDescrption : String = "Cook for dinner"
        let loc : String = "Kitchen"
        let mockActData : ActivityDataModel = ActivityDataModel(timeStamp: Date(), activityDescription: activityDescrption, location: loc)

        enumerateDates(
            startingAfter: start,
            matching: .everyDay,
            matchingPolicy: .nextTime) { date, _, stop in
            if let date = date {
                if date < end {
                    for _ in 0..<Int.random(in: visitCountRange) {
                        visits.append(.mock(withDate: date))
                        visits.append(.withData(data: mockActData))
                    }
                } else {
                    stop = true
                }
            }
        }

        return visits
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

fileprivate extension DateComponents {

    static var everyDay: DateComponents {
        DateComponents(hour: 0, minute: 0, second: 0)
    }

}


