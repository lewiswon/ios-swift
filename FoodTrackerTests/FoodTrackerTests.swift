//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by LuoLewis on 15/11/3.
//  Copyright © 2015年 LuoLewis. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    //Tests to confirm that the Meal initializer returns when no name or a nagetive rating is provided
    func testMealInitialization(){
        //Sucess case.
        let potentialItem = Meal(name:"Newestmeal",photo:nil,rating:5)

        XCTAssertNil(potentialItem)
        
        //Failure case.
        let noName = Meal(name: "aaa", photo:nil, rating: 0)
        XCTAssertNil(noName,"empty name is invalid")
        
        let badRating = Meal(name: "beef", photo: nil, rating: -1)
        XCTAssertNil(badRating,"Negative ratings are invalid,be positive")
    }
    
    
    
}
