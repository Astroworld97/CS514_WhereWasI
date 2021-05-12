//
//  BeaconDetector.swift
//  Where Was I
//
//  Created by Shuangquan Li on 3/8/21.
//

import Combine
import CoreLocation
import UserNotifications


/// Detect beacons and do follow up actions
class BeaconDetector: CLLocationManager, ObservableObject, CLLocationManagerDelegate{
    
    @Published var lastDistance = CLProximity.unknown
    private var didChange = PassthroughSubject<Void, Never>()
    private var locationManager: CLLocationManager?
    var count = 0
    var isPushed = false
    var notificationManager = NotificationManager()
    let locations = Locations()
    let persistenceContainer = PersistenceController.shared
    
    let newActivity: ActivityDataModel = ActivityDataModel.init()
    var perviousUUID = UUID()
    
    override init(){
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.allowsBackgroundLocationUpdates = true
        
    }
    
    
    /// Check user authorization, if authorized start monitoring beacons
    /// - Parameters:
    ///   - manager: location manager
    ///   - status: status of the user authorization
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            print("Bluetooth authorized")
            
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                if CLLocationManager.isRangingAvailable(){
                    print("monitoring available, ranging available")
                    
                    
                    monitorBeacons(identifier: "location_1")
                    
                    
                    
                    
                }
            }
        }
    }
    
    
    
    
    /// monitor beacons with pre set constraint
    /// - Parameter identifier: description of the beacon
    func monitorBeacons(identifier: String) {
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            
            // Match all beacons with the specified UUID
            ///Mark: replace with real iBeacon device's UUID
            let uuid = UUID(uuidString: "426C7565-4368-6172-6D42-6561636F6E73")!
            
            let constraint = CLBeaconIdentityConstraint(uuid: uuid)
            
            // Create the region and begin monitoring it.
            ///Mark: replace with real iBeacon device's identifier value
            let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: identifier)
            
            //beaconRegion.notifyOnEntry = true
            //beaconRegion.notifyOnExit = true
            
            self.locationManager?.startMonitoring(for: beaconRegion)
            
            ///Mark: For testing environment, uncomment following...
            locationManager?.startRangingBeacons(satisfying: constraint)
            locationManager?.startUpdatingLocation()
            print("start monitoring...")
        }
    }
    
    var preMinor = -1
    
    /// A set of action for matching beacon was found
    /// The iPhone found the location, and send notification to user. It will ask user to enter what he is doing.
    /// Then Database model handler will save the data into database
    /// 
    /// - Parameters:
    ///   - manager: location manager
    ///   - beacons: BLE beacons
    ///   - beaconConstraint: beacon constraint
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
            
            
            let major = CLBeaconMajorValue(truncating: beacon.major)
            let minor = CLBeaconMinorValue(truncating: beacon.minor)
            
            
            
            if beacon.proximity != .immediate && preMinor != minor{// reset push notification status
                isPushed = false
                print("changed! current minor: \(minor), pre minor: \(preMinor)")
            }
            
            if beacon.proximity == .immediate && isPushed == false { // nearest beacon
                print("right here, major: \(major), minor: \(minor)")
                isPushed = true
                let location = locations.getLocation(minor: Int(minor))
                
                notificationManager.sendNotification(title: "[\(location)]", subtitle: "What I've done? What should I do?", body: "Long press me to select one blow", launchIn: 0.05, whichLocation: Int(minor))
                
                newActivity.setLocation(location: location)
                newActivity.setDateTime(date: NSDate.init() as Date)
                newActivity.setUUID(uuid: UUID())
                
                NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived), name: NSNotification.Name("UNTextInputNotificationResponse"), object: nil)
                
                
                NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived), name: NSNotification.Name("LivingRoomAction"), object: nil)
                
                NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived), name: NSNotification.Name("BedRoomAction"), object: nil)
                
                NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived), name: NSNotification.Name("KitchenAction"), object: nil)
                
                NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived), name: NSNotification.Name("GarageAction"), object: nil)
                
                NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived), name: NSNotification.Name("BathRoomAction"), object: nil)
                
                preMinor = Int(minor)
            }
            
        }else{
            update(distance: .unknown)
        }
        count+=1
//        print("updated \(count), distance:\(lastDistance.rawValue)")
    }
    
    
    @objc func notificationReceived(notification: Notification) {
       print("Action entered: \(notification.object!)")
        newActivity.setActivityDescription(activityDescription: notification.object! as! String)
        

        
        if perviousUUID != newActivity.getUUID(){
        
            Activity.addAct(viewContext: persistenceContainer.container.viewContext, activityDataModel: newActivity)
            
        }
        
        perviousUUID = newActivity.getUUID()
        
     }
    
    
    func update(distance: CLProximity){
        lastDistance = distance
        didChange.send(())
    }
    
    
    
    /// Enter the BLE beacon region, start ranging beacons
    /// - Parameters:
    ///   - manager: location manager
    ///   - region: region of beacons
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard region is CLBeaconRegion else {
            return
        }
        
        notificationManager.sendNotification(title: "enter \(region.identifier)", subtitle: "I am enter", body: "1111", launchIn: 0.01, whichLocation: -1)
        print("enter")
        
        
        if region is CLBeaconRegion {
            // Start ranging only if the devices supports this service.
            if CLLocationManager.isRangingAvailable() {
                manager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: UUID(uuidString: "426C7565-4368-6172-6D42-6561636F6E73")!))
                
                // Store the beacon so that ranging can be stopped on demand.
                //beaconsToRange.append(region as! CLBeaconRegion)
                
                
                ///Mark: For production environment, uncomment following...
                print("Start ranging.......")
//                locationManager?.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: UUID(uuidString: "B0702880-A295-A8AB-F734-031A98A512DE")!))
//                locationManager?.startUpdatingLocation()

                
            }
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        guard region is CLBeaconRegion else {
            return
        }
        
        // region.notifyOnExit = true
        notificationManager.sendNotification(title: "exit \(region.identifier)", subtitle: "I am exited", body: "1111", launchIn: 0.01, whichLocation: -1)
        print("exit")
        
        locationManager?.stopRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: UUID(uuidString: "426C7565-4368-6172-6D42-6561636F6E73")!))
        locationManager?.stopUpdatingLocation()
    }
    
    func getLastLocation() -> CLProximity{
        return self.lastDistance
    }
    
}
