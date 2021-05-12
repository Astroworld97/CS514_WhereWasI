//
//  MainView.swift
//  Where Was I
//
//  Created by Shuangquan Li on 3/3/21.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView {
            TodayView()
                   .tabItem {
                       Image(systemName: "list.bullet.rectangle")
                       Text("Today")
                   }

            HistoryView()
                   .tabItem {
                       Image(systemName: "calendar.badge.clock")
                       Text("History")
                   }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
