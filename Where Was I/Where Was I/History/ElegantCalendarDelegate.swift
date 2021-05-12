//
//  ElegantCalendarDelegate.swift
//  Where Was I
//
//  Created by Ian Gonzalez on 4/22/21.
//

import SwiftUI
import ElegantCalendar

extension ExampleCalendarView: ElegantCalendarDelegate {
    func calendar(didSelectDay date: Date) {
        print("Selected date: \(date)")
    }

    func calendar(willDisplayMonth date: Date) {
        print("Month displayed: \(date)")
    }

    func calendar(didSelectMonth date: Date) {
        print("Selected month: \(date)")
    }

    func calendar(willDisplayYear date: Date) {
        print("Year displayed: \(date)")
    }
}
