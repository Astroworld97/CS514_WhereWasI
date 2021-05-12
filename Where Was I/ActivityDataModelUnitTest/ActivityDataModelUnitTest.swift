//
//  ActivityDataModelUnitTest.swift
//  ActivityDataModelUnitTest
//
//  Created by Shuangquan on 3/10/21.
//

import XCTest
@testable import Where_Was_I

class ActivityDataModelUnitTest: XCTestCase {
    
    var ac0: ActivityDataModel! = nil
    var ac1: ActivityDataModel! = nil
    var ac2: ActivityDataModel! = nil
    
    let formatter: DateFormatter = DateFormatter()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        ac0 = ActivityDataModel()
        ac1 = ActivityDataModel(timeStamp: Date(), activityDescription: "drink", location: "kitchen")
        ac2 = ActivityDataModel(timeStamp: Date(), activityDescription: "sleep", location: "bedroom", activityDetail: "I took a nap after lunch. It was great!")
        

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetDate() throws {
        XCTAssertEqual(ac0.getDateTime(), "\(formatter.string(from: Date()))")
        XCTAssertEqual(ac1.getDateTime(), "\(formatter.string(from: Date()))")
        XCTAssertEqual(ac2.getDateTime(), "\(formatter.string(from: Date()))")
    }
    
    func testSetDAte() throws {
        ac0.setDateTime(date: Date())
        XCTAssertEqual(ac0.getDateTime(), "\(formatter.string(from: Date()))")
    }
    
    func testGetDescription() throws {
        XCTAssertEqual(ac0.getActivityDescription(), "")
        XCTAssertEqual(ac1.getActivityDescription(), "drink")
    }
    
    func testSetDescription() throws {
        ac0.setActivityDescription(activityDescription: "eat")
        XCTAssertEqual(ac0.getActivityDescription(), "eat")
        ac1.setActivityDescription(activityDescription: "fly")
        XCTAssertEqual(ac1.getActivityDescription(), "fly")
    }
    
    func testGetLocation() throws {
        XCTAssertEqual(ac0.getLocation(), "N/A")
        XCTAssertEqual(ac1.getLocation(), "kitchen")
    }
    
    func testSetLocation() throws {
        ac0.setLocation(location: "living room")
        XCTAssertEqual(ac0.getLocation(), "living room")
        ac1.setLocation(location: "bed room")
        XCTAssertEqual(ac1.getLocation(), "bed room")
    }
    
    func testGetDetail() throws {
        XCTAssertEqual(ac0.getActivityDetail(), "")
        XCTAssertEqual(ac1.getActivityDetail(), "")
        XCTAssertEqual(ac2.getActivityDetail(), "I took a nap after lunch. It was great!")
    }
    
    func testSetDetail() throws {
        ac2.setActivityDetail(activityDetail: "I read a book about American history.")
        XCTAssertEqual(ac2.getActivityDetail(), "I read a book about American history.")
    }
    
}
