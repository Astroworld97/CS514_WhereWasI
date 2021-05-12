//
//  Locations.swift
//  Where Was I
//
//  Created by Shuangquan on 4/19/21.
//

import Foundation

struct Locations {
    
    // init stauts
    var minor: Int = -1
    
    let locationDict = [1:"Living Room", 2: "Bed Room", 3:"Kitchen", 4:"Garage", 5:"Bath Room"]
    
    
    func getLocation(minor: Int) -> String{
        
        if minor > 5 || minor < 1{
            return "Unknown"
        }else{
            return locationDict[minor]!

        }
        
    }
    
}
