//
//  NotificationManager.swift
//  Where Was I
//
//  Created by Shuangquan on 3/11/21.
//

import UserNotifications

/// Sends out notifications according to user's location
class NotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate{
    
    
    /// Authorization check
    override init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("Notifications permitted")
            } else {
                print("Notifications not permitted")
            }
        }
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("userNotificationCenter - willPresent")
        completionHandler([.badge, .banner,.sound])
    }
    
    
    /* This method is called when:
     1. User dismisses a notification
     2. User simply opens a notification
     3. User selects an UNNotificationAction
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Clicked UNNotificationAction id: \(response.actionIdentifier)")
        
        
        switch response.actionIdentifier {
        
        case UNNotificationDefaultActionIdentifier:
            print("Notification is simply opened.")
        case UNNotificationDismissActionIdentifier:
            // This is only triggered when `.customDismissAction` is set to the `UNNotificationCategory`
            print("Notification is dismissed.")
            
        case "Living_ROOM_ACTIONS_1":
            NotificationCenter.default.post(name: NSNotification.Name("LivingRoomAction"), object: "TV operation")
        case "Living_ROOM_ACTIONS_2":
            NotificationCenter.default.post(name: NSNotification.Name("LivingRoomAction"), object: "Lights operation")
        case "Living_ROOM_ACTIONS_3":
            NotificationCenter.default.post(name: NSNotification.Name("LivingRoomAction"), object: "Windows operation")
            
        case "Bed_ROOM_ACTIONS_1":
            NotificationCenter.default.post(name: NSNotification.Name("BedRoomAction"), object: "Take a nap")
        case "Bed_ROOM_ACTIONS_2":
            NotificationCenter.default.post(name: NSNotification.Name("BedRoomAction"), object: "Sleep")
        case "Bed_ROOM_ACTIONS_3":
            NotificationCenter.default.post(name: NSNotification.Name("BedRoomAction"), object: "Set an alarm")
            
        case "Kitchen_ACTIONS_1":
            NotificationCenter.default.post(name: NSNotification.Name("KitchenAction"), object: "Cook")
        case "Kitchen_ACTIONS_2":
            NotificationCenter.default.post(name: NSNotification.Name("KitchenAction"), object: "Drink")
        case "Kitchen_ACTIONS_3":
            NotificationCenter.default.post(name: NSNotification.Name("KitchenAction"), object: "Oven operation")
            
        case "Garage_ACTIONS_1":
            NotificationCenter.default.post(name: NSNotification.Name("GarageAction"), object: "Garage door operation")
        case "Garage_ACTIONS_2":
            NotificationCenter.default.post(name: NSNotification.Name("GarageAction"), object: "Car engine operation")
            
        case "BATH_ROOM_ACTIONS_1":
            NotificationCenter.default.post(name: NSNotification.Name("BathRoomAction"), object: "Shower")
        case "BATH_ROOM_ACTIONS_2":
            NotificationCenter.default.post(name: NSNotification.Name("BathRoomAction"), object: "Wash hand")
        case "BATH_ROOM_ACTIONS_3":
            NotificationCenter.default.post(name: NSNotification.Name("BathRoomAction"), object: "Faucet operation")
       
            
        
        case "textInputNotificationActionIdentifier":
            
            
            print("UNNotificationAction with a UITextField is triggered.")
            let textInputNotificationResponse = response as! UNTextInputNotificationResponse
            let userInputtedText = textInputNotificationResponse.userText
            
            // Notify target ViewController through NotificationCenter
            NotificationCenter.default.post(name: NSNotification.Name("UNTextInputNotificationResponse"), object: userInputtedText)
        default:
            print("Unknown identifier")
        }
        
        print("userNotificationCenter - didReceive")
        // Developer must execute this block at some point after processing the user's response
        // to let the system know that you are done.
        completionHandler()
    }
    
    func sendNotification(title: String, subtitle: String?, body: String, launchIn: Double, whichLocation: Int) {
        
        let content = UNMutableNotificationContent()
        content.sound = .default
        
        content.title = title
        if let subtitle = subtitle {
            content.subtitle = subtitle
        }
        content.body = body
        
        switch whichLocation {
        case 1:
            setupUNNotificationCategory_LivingRoom()
            content.categoryIdentifier = "Living_Room"
            print("Set up categ. for living room")
        case 2:
            
            setupUNNotificationCategory_BedRoom()
            
            content.categoryIdentifier = "Bed_Room"
            print("Set up categ. for bed room")
        case 3:
            setupUNNotificationCategory_Kitchen()
            content.categoryIdentifier = "Kitchen"
            print("Set up categ. for kitchen")
        case 4:
            setupUNNotificationCategory_Garage()
            content.categoryIdentifier = "Garage"
            print("Set up categ. for garage")
        case 5:
            setupUNNotificationCategory_BathRoom()
            content.categoryIdentifier = "Bath_Room"
            print("Set up categ. for batch room")
        default:
            content.categoryIdentifier = "-1"
            print("Set up categ. other")
        }
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: launchIn, repeats: false)
        let request = UNNotificationRequest(identifier: "IN-APP", content: content, trigger: trigger)
        
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        UNUserNotificationCenter.current().delegate = self
        
    }
    
    
    
    func setupUNNotificationCategory_LivingRoom() {
        // Simple button
        
        
        let action1 = UNNotificationAction(identifier: "Living_ROOM_ACTIONS_1", title: "TV on/off?", options: [.foreground])
        let action2 = UNNotificationAction(identifier: "Living_ROOM_ACTIONS_2", title: "Light on/off?", options: [.foreground])
        let action3 = UNNotificationAction(identifier: "Living_ROOM_ACTIONS_3", title: "Window open/closed?", options: [.foreground])
        
        
        
        // Button shows a UITextInput and confirm button
        let textInputNotificationAction = UNTextInputNotificationAction(identifier: "textInputNotificationActionIdentifier", title: "None above? Enter your own", options: [.foreground], textInputButtonTitle: "Done", textInputPlaceholder: "Enter your activities:")
        
        // Add `Action` to a category
        let actions = [action1, action2, action3, textInputNotificationAction]
        let category = UNNotificationCategory(identifier: "Living_Room", actions: actions, intentIdentifiers: ["fooIntentIdentifiers"], options: [.customDismissAction])
        
        // Set Category to NotificationCenter
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    
    func setupUNNotificationCategory_BedRoom() {
        // Simple button
        let action1 = UNNotificationAction(identifier: "Bed_ROOM_ACTIONS_1", title: "Take a nap", options: [.foreground])
        let action2 = UNNotificationAction(identifier: "Bed_ROOM_ACTIONS_2", title: "Sleep", options: [.foreground])
        let action3 = UNNotificationAction(identifier: "Bed_ROOM_ACTIONS_3", title: "Set an alarm", options: [.foreground])

        
        // Button shows a UITextInput and confirm button
        let textInputNotificationAction = UNTextInputNotificationAction(identifier: "textInputNotificationActionIdentifier", title: "None above? Enter your own", options: [.foreground], textInputButtonTitle: "Done", textInputPlaceholder: "Enter your activities:")
        
        // Add `Action` to a category
        let actions = [action1, action2, action3, textInputNotificationAction]
        let category = UNNotificationCategory(identifier: "Bed_Room", actions: actions, intentIdentifiers: ["fooIntentIdentifiers"], options: [.customDismissAction])
        
        // Set Category to NotificationCenter
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    
    func setupUNNotificationCategory_Kitchen() {
        // Simple button
        let action1 = UNNotificationAction(identifier: "Kitchen_ACTIONS_1", title: "Cook", options: [.foreground])
        let action2 = UNNotificationAction(identifier: "Kitchen_ACTIONS_2", title: "Drink", options: [.foreground])
        let action3 = UNNotificationAction(identifier: "Kitchen_ACTIONS_3", title: "Oven on/off?", options: [.foreground])
        
        // Button shows a UITextInput and confirm button
        let textInputNotificationAction = UNTextInputNotificationAction(identifier: "textInputNotificationActionIdentifier", title: "None above? Enter your own", options: [.foreground], textInputButtonTitle: "Done", textInputPlaceholder: "Enter your activities:")
        
        // Add `Action` to a category
        let actions = [action1, action2, action3, textInputNotificationAction]
        let category = UNNotificationCategory(identifier: "Kitchen", actions: actions, intentIdentifiers: ["fooIntentIdentifiers"], options: [.customDismissAction])
        
        // Set Category to NotificationCenter
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    
    func setupUNNotificationCategory_Garage() {
        // Simple button
        let action1 = UNNotificationAction(identifier: "Garage_ACTIONS_1", title: "Garage Door open/closed?", options: [.foreground])
        let action2 = UNNotificationAction(identifier: "Garage_ACTIONS_2", title: "Car engine on/off?", options: [.foreground])
        
        // Button shows a UITextInput and confirm button
        let textInputNotificationAction = UNTextInputNotificationAction(identifier: "textInputNotificationActionIdentifier", title: "None above? Enter your own", options: [.foreground], textInputButtonTitle: "Done", textInputPlaceholder: "Enter your activities:")
        
        // Add `Action` to a category
        let actions = [action1, action2, textInputNotificationAction]
        let category = UNNotificationCategory(identifier: "Garage", actions: actions, intentIdentifiers: ["fooIntentIdentifiers"], options: [.customDismissAction])
        
        // Set Category to NotificationCenter
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    
    func setupUNNotificationCategory_BathRoom() {
        // Simple button
        let action1 = UNNotificationAction(identifier: "BATH_ROOM_ACTIONS_1", title: "Shower", options: [.foreground])
        let action2 = UNNotificationAction(identifier: "BATH_ROOM_ACTIONS_2", title: "Wash hand", options: [.foreground])
        let action3 = UNNotificationAction(identifier: "BATH_ROOM_ACTIONS_3", title: "Faucet on/off?", options: [.foreground])
        
        // Button shows a UITextInput and confirm button
        let textInputNotificationAction = UNTextInputNotificationAction(identifier: "textInputNotificationActionIdentifier", title: "None above? Enter your own", options: [.foreground], textInputButtonTitle: "Done", textInputPlaceholder: "Enter your activities:")
        
        // Add `Action` to a category
        let actions = [action1, action2, action3, textInputNotificationAction]
        let category = UNNotificationCategory(identifier: "Bath_Room", actions: actions, intentIdentifiers: ["fooIntentIdentifiers"], options: [.customDismissAction])
        
        // Set Category to NotificationCenter
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    
    
}





