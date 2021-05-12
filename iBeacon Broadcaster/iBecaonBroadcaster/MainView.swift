//
//  ContentView.swift
//  iBeaconBroadcaster
//
//  Created by Shuangquan Li on 3/1/21.
//

import SwiftUI
import CoreBluetooth
import CoreLocation
import Combine


class BLEManager:NSObject,ObservableObject,CBPeripheralManagerDelegate{
    
    @Published var statusMessage = "Stopped, Tap the Button to Begin Broadcasting"
    @Published var disabled = false
    
    private let beaconIdentity = "location_2"
    private let beaconUUID = "B0702880-A295-A8AB-F734-031A98A512DE"
    private let beaconMajorValue = CLBeaconMajorValue(2)
    private let beaconMinorValue = CLBeaconMajorValue(8)
    private var peripheraManager: CBPeripheralManager?
    
    
    override init() {
        super.init()
        peripheraManager = CBPeripheralManager(delegate: self, queue: .main)
    }
    
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
        switch peripheral.state {
        case .unknown:
            print("BLE Unknow")
        case .resetting:
            print("BLE Resetting")
        case .unsupported:
            print("BLE Unsupported")
            self.disabled = true
            self.statusMessage = "Unsupported Device"
        case .unauthorized:
            print("BLE Unauthorized")
            self.disabled = true
            self.statusMessage = "Bluetooth Unauthorized"
        case .poweredOff:
            print("BLE Porwered Off")
            self.disabled = true
            self.statusMessage = "Bluetooth Off"
        case .poweredOn:
            print("BLE On")
            self.disabled = false
            self.statusMessage = "Bluetooth On, ready for broadcasting..."
            //beaconAdvertising()
        @unknown default:
            print("Unknow state")
            fatalError()
        }
    }
    
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print("正在模拟Beacon广播数据: \(peripheral.isAdvertising) --- 错误信息: \(String(error?.localizedDescription ?? "无"))")
        
        
        statusMessage = "Is Broadcasting: \(peripheral.isAdvertising)\nError Message: \(error?.localizedDescription ?? "None")"
       
    }
    
    
    func beaconAdvertising() {
        
        guard let uuid = UUID(uuidString: beaconUUID) else {
            return
        }
        let region = CLBeaconRegion.init(uuid: uuid, major: beaconMajorValue, minor: beaconMinorValue, identifier: beaconIdentity)
        let regionData = region.peripheralData(withMeasuredPower: nil)
        let regionAdvertising = regionData as? [String : Any]
        peripheraManager?.startAdvertising(regionAdvertising)
        print("Start BLE advertising: \(regionData)")
    }
    
    func stopAdvertising(){
        peripheraManager?.stopAdvertising()
        statusMessage = "Stop Broadcasting"
    }
    
    
}

struct MainView: View {
    
    @ObservedObject var bleManager: BLEManager = BLEManager.init()
    
    @State var isBroadcasting = false
    
    
    var body: some View {
        
        VStack{
            Spacer()
            Text("\(bleManager.statusMessage)")
            Spacer()
            Button{
               
                
                if self.isBroadcasting == false{
                    bleManager.beaconAdvertising()
                    self.isBroadcasting.toggle()
                }else{
                    bleManager.stopAdvertising()
                    self.isBroadcasting.toggle()
                }
                
            } label:{
                
                
                if self.isBroadcasting == false{
                    Text("Start Broadcasting")
                }else{
                    Text("Stop Broadcasting")
                }
            }
            .disabled(bleManager.disabled)
            
        }
            .padding()
        
        
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
