//
//  Where_Was_IApp.swift
//  Where Was I
//
//  Created by Shuangquan Li on 3/3/21.
//

import SwiftUI

@main
struct Where_Was_IApp: App {
    
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        
        let persistenceContainer = PersistenceController.shared
        
        WindowGroup {
            
            MainView()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}



//class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
//
//  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//    //setupUNNotificationCategory_LivingRoom()
//    //setupUNNotificationCategory_BedRoom()
//    //setupUNNotificationCategory_Kitchen()
//    //setupUNNotificationCategory_Garage()
//    //setupUNNotificationCategory_BathRoom()
//    return true
//  }
//
//  func setupUNNotificationCategory_LivingRoom() {
//    // Simple button
//    let destructiveAction = UNNotificationAction(identifier: "destructiveActionIdentifier", title: "living", options: [.destructive])
//    let authenticationRequiredAction = UNNotificationAction(identifier: "authenticationRequiredActionIdentifier", title: "authenticationRequiredAction", options: [.authenticationRequired])
//    let foregroundAction = UNNotificationAction(identifier: "foregroundActionIdentifier", title: "foregroundAction", options: [.foreground])
//
//
//    // Button shows a UITextInput and confirm button
//    let textInputNotificationAction = UNTextInputNotificationAction(identifier: "textInputNotificationActionIdentifier", title: "None above? Set up your own", options: [.foreground], textInputButtonTitle: "Done", textInputPlaceholder: "Enter your activities:")
//
//    // Add `Action` to a category
//    let actions = [destructiveAction, authenticationRequiredAction, foregroundAction, textInputNotificationAction]
//    let category = UNNotificationCategory(identifier: "Living_Room", actions: actions, intentIdentifiers: ["fooIntentIdentifiers"], options: [.customDismissAction])
//
//    // Set Category to NotificationCenter
//    UNUserNotificationCenter.current().setNotificationCategories([category])
//  }
//
//
//    func setupUNNotificationCategory_BedRoom() {
//      // Simple button
//      let destructiveAction = UNNotificationAction(identifier: "destructiveActionIdentifier", title: "bed", options: [.destructive])
//      let authenticationRequiredAction = UNNotificationAction(identifier: "authenticationRequiredActionIdentifier", title: "321", options: [.authenticationRequired])
//      let foregroundAction = UNNotificationAction(identifier: "foregroundActionIdentifier", title: "foregroundAction", options: [.foreground])
//
//      // Button shows a UITextInput and confirm button
//      let textInputNotificationAction = UNTextInputNotificationAction(identifier: "textInputNotificationActionIdentifier", title: "None above? Set up your own", options: [.foreground], textInputButtonTitle: "Done", textInputPlaceholder: "Enter your activities:")
//
//      // Add `Action` to a category
//      let actions = [destructiveAction, authenticationRequiredAction, foregroundAction, textInputNotificationAction]
//      let category = UNNotificationCategory(identifier: "Bed_Room", actions: actions, intentIdentifiers: ["fooIntentIdentifiers"], options: [.customDismissAction])
//
//      // Set Category to NotificationCenter
//      UNUserNotificationCenter.current().setNotificationCategories([category])
//    }
//
//
//    func setupUNNotificationCategory_Kitchen() {
//      // Simple button
//      let destructiveAction = UNNotificationAction(identifier: "destructiveActionIdentifier", title: "kitchen", options: [.destructive])
//      let authenticationRequiredAction = UNNotificationAction(identifier: "authenticationRequiredActionIdentifier", title: "321", options: [.authenticationRequired])
//      let foregroundAction = UNNotificationAction(identifier: "foregroundActionIdentifier", title: "foregroundAction", options: [.foreground])
//
//      // Button shows a UITextInput and confirm button
//      let textInputNotificationAction = UNTextInputNotificationAction(identifier: "textInputNotificationActionIdentifier", title: "None above? Set up your own", options: [.foreground], textInputButtonTitle: "Done", textInputPlaceholder: "Enter your activities:")
//
//      // Add `Action` to a category
//      let actions = [destructiveAction, authenticationRequiredAction, foregroundAction, textInputNotificationAction]
//      let category = UNNotificationCategory(identifier: "Kitchen", actions: actions, intentIdentifiers: ["fooIntentIdentifiers"], options: [.customDismissAction])
//
//      // Set Category to NotificationCenter
//      UNUserNotificationCenter.current().setNotificationCategories([category])
//    }
//
//
//    func setupUNNotificationCategory_Garage() {
//      // Simple button
//      let destructiveAction = UNNotificationAction(identifier: "destructiveActionIdentifier", title: "garge", options: [.destructive])
//      let authenticationRequiredAction = UNNotificationAction(identifier: "authenticationRequiredActionIdentifier", title: "321", options: [.authenticationRequired])
//      let foregroundAction = UNNotificationAction(identifier: "foregroundActionIdentifier", title: "foregroundAction", options: [.foreground])
//
//      // Button shows a UITextInput and confirm button
//      let textInputNotificationAction = UNTextInputNotificationAction(identifier: "textInputNotificationActionIdentifier", title: "None above? Set up your own", options: [.foreground], textInputButtonTitle: "Done", textInputPlaceholder: "Enter your activities:")
//
//      // Add `Action` to a category
//      let actions = [destructiveAction, authenticationRequiredAction, foregroundAction, textInputNotificationAction]
//      let category = UNNotificationCategory(identifier: "Garage", actions: actions, intentIdentifiers: ["fooIntentIdentifiers"], options: [.customDismissAction])
//
//      // Set Category to NotificationCenter
//      UNUserNotificationCenter.current().setNotificationCategories([category])
//    }
//
//
//    func setupUNNotificationCategory_BathRoom() {
//      // Simple button
//      let destructiveAction = UNNotificationAction(identifier: "destructiveActionIdentifier", title: "bath", options: [.destructive])
//      let authenticationRequiredAction = UNNotificationAction(identifier: "authenticationRequiredActionIdentifier", title: "321", options: [.authenticationRequired])
//      let foregroundAction = UNNotificationAction(identifier: "foregroundActionIdentifier", title: "foregroundAction", options: [.foreground])
//
//      // Button shows a UITextInput and confirm button
//      let textInputNotificationAction = UNTextInputNotificationAction(identifier: "textInputNotificationActionIdentifier", title: "None above? Set up your own", options: [.foreground], textInputButtonTitle: "Done", textInputPlaceholder: "Enter your activities:")
//
//      // Add `Action` to a category
//      let actions = [destructiveAction, authenticationRequiredAction, foregroundAction, textInputNotificationAction]
//      let category = UNNotificationCategory(identifier: "Bath_Room", actions: actions, intentIdentifiers: ["fooIntentIdentifiers"], options: [.customDismissAction])
//
//      // Set Category to NotificationCenter
//      UNUserNotificationCenter.current().setNotificationCategories([category])
//    }
//
//
//
//
//}

