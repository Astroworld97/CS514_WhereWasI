//
//  ChangeThemeButton.swift
//  Where Was I
//
//  Created by Ian Gonzalez on 3/24/21.
//


import ElegantCalendar
import SwiftUI

struct ChangeThemeButton: View {

    @Binding var calendarTheme: CalendarTheme

    var body: some View {
        Button(action: {
            self.calendarTheme = .randomTheme
        }) {
            //Text("CHANGE THEME")
            Image(systemName: "calendar")
            //Image(systemName: "calendar.circle")
            //Image(systemName: "calendar.circle.fill")
        }
    }

}

private extension CalendarTheme {

    static var randomTheme: CalendarTheme {
        let randomNumber = arc4random_uniform(UInt32(CalendarTheme.allThemes.count))
        return CalendarTheme.allThemes[Int(randomNumber)]
    }

}


