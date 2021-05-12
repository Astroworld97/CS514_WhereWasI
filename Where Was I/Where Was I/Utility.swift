//
//  Utility.swift
//  Where Was I
//
//  Created by Hao Jiang on 4/20/21.
//

import Foundation

class Utility {
    
    init(){}
    
    func getToday() -> String{
        let formatter = DateFormatter()
        /// 2021-04-15 format
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
    
}
