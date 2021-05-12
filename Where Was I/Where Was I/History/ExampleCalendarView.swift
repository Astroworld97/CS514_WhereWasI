//
//  ExampleCalendarView.swift
//  Where Was I
//
//  Created by Ian Gonzalez on 4/22/21.
//

import SwiftUI
import ElegantCalendar
import UIKit


struct ExampleCalendarView: View {
    //example

    @ObservedObject private var calendarManager:
        ElegantCalendarManager

    public let visitsByDay: [Date: [Visit]]
    @State private var calendarTheme: CalendarTheme = .royalBlue
    @State var topPadding: CGFloat = 0.0
    @State var bottomPadding: CGFloat = 0.0
    @State var leadingPadding: CGFloat = 0.0
    var name = UIDevice.current.name
    
    // ascVisits: a date range to show?
    public init(ascVisits: [Visit], initialMonth: Date?) {
        let configuration = CalendarConfiguration(
            calendar: currentCalendar,
            startDate: ascVisits.first?.arrivalDate ?? Date(),
            endDate: ascVisits.last?.arrivalDate ?? Date())

        calendarManager = ElegantCalendarManager(
            configuration: configuration,
            initialMonth: initialMonth)
        
        
        

        visitsByDay = Dictionary(
            grouping: ascVisits,
            by: { currentCalendar.startOfDay(for: $0.arrivalDate) })

        calendarManager.datasource = self
        calendarManager.delegate = self
    }
    
    // Start & End date should be configured based on your needs.
//    let startDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (-30 * 36)))
//    let endDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (30 * 36)))
//
//    @ObservedObject var calendarManager = ElegantCalendarManager(
//        configuration: CalendarConfiguration(startDate: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (-30 * 36))),
//                                             endDate: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (30 * 36)))))
    
    //stacks the calendar on top of the changeThemeButton
    var body: some View {
        ZStack {
            ElegantCalendarView(calendarManager: calendarManager)
                .theme(calendarTheme)
            VStack {
                Spacer()
                changeThemeButton
                    .padding(.bottom, bottomPadding)
                    .padding(.leading, leadingPadding)
                    .padding(.top, topPadding)
            }.onAppear(){
                if (name == "iPhone 8"){ //good
                    bottomPadding = 625.0
                    leadingPadding = 275.0
                    topPadding = 100.0
                }
                else if(name == "iPhone 8 Plus"){ //good
                    bottomPadding = 675.0
                    leadingPadding = 300.0
                    topPadding = 100.0
                }
                else if(name == "iPhone 11"){ //good
                    bottomPadding = 800.0
                    leadingPadding = 300.0
                    topPadding = 50.0
                }
                else if (name == "iPhone 11 Pro"){ //good
                    bottomPadding = 720.0
                    leadingPadding = 300.0
                    topPadding = 50.0
                }else if(name == "iPhone 11 Pro Max"){ //good
                    bottomPadding = 800.0
                    leadingPadding = 300.0
                    topPadding = 50.0
                }
                else if(name=="iPhone 12"){ //good
                    bottomPadding = 750.0
                    leadingPadding = 300.0
                    topPadding = 50.0
                }else if(name == "iPhone 12 Pro"){ //good
                    bottomPadding = 775.0
                    leadingPadding = 330.0
                    topPadding = 100.0
                }else if(name == "iPhone 12 Pro Max"){ //good
                    bottomPadding = 825.0
                    leadingPadding = 300.0
                    topPadding = 50.0
                }else if(name == "iPhone 12 mini"){ //good
                    bottomPadding = 725.0
                    leadingPadding = 300.0
                    topPadding = 50.0
                }else if(name == "iPhone SE (2nd generation)"){ //good
                    bottomPadding = 600.0
                    leadingPadding = 300.0
                    topPadding = 50.0
                }
            }
        }
        
    }
    
    
    
    //Change the theme, aka the color, of the calendar
    private var changeThemeButton: some View {
        ChangeThemeButton(calendarTheme: $calendarTheme)
    }
}





