//
//  ElegantCalendarDataSource.swift
//  Where Was I
//
//  Created by Ian Gonzalez on 4/22/21.
//

import SwiftUI
import ElegantCalendar

extension ExampleCalendarView: ElegantCalendarDataSource {

    func calendar(backgroundColorOpacityForDate date: Date) -> Double {
        let startOfDay = currentCalendar.startOfDay(for: date)
        return Double(visitsByDay[startOfDay]?.count ?? 0) //if visitsByDay[startOfDay]?.count is nil, returns 0, else returns the value of visitsByDay[startOfDay]?.count before doing the calculation
            //also, executes the .count method if visitsByDay[startOfDay] exists.
    }

    func calendar(canSelectDate date: Date) -> Bool {
        let day = currentCalendar.dateComponents([.day], from: date).day!
        return day != 4
    }

    //needed to be able to show activities in the day they belong.
    func calendar(viewForSelectedDate date: Date, dimensions size: CGSize) -> AnyView {
        let startOfDay = currentCalendar.startOfDay(for: date)
        return VisitsListView(visits: visitsByDay[startOfDay] ?? [], height: size.height).erased
    }
}
