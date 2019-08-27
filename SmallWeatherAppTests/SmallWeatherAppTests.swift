//
//  SmallWeatherAppTests.swift
//  SmallWeatherAppTests
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//

import XCTest
@testable import SmallWeatherApp

class SmallWeatherAppTests: XCTestCase {
    var citiesName: [String] = []
    
    let mockApi = SWMockApiManager()
    let realApi = SWRequestManager()
    
    override func setUp() {
        citiesName = ["Kiev", "New York", "Moscow"]
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWeatherWithCity() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        mockApi.getWeather(withCityName: citiesName[0]) { (city, success, errorMessage, error) in
            print("error message \(String(describing: errorMessage))")
            assert(success)
            print(city as Any)
        }
    }
    
    func testRealApiWeather() {
        let semaphore = DispatchSemaphore(value: 0)
        
        realApi.getWeather(withCityName: "Kyiv") { (city, succes, errorMessage, error) in
            if succes {
                print(city as Any)
            } else {
                print(error as Any)
                print(errorMessage as Any)
            }
            assert(succes)
            semaphore.signal()
        }
        semaphore.wait()
    }
    
    func testConcurrentLoopWeatherRequest() {
        let semaphore = DispatchSemaphore(value: 0)
        let dispatchGroup = DispatchGroup()
        let _ = DispatchQueue.global(qos: .userInitiated)
        
        DispatchQueue.concurrentPerform(iterations: citiesName.count) { (cityIndex) in
            dispatchGroup.enter()
            realApi.getWeather(withCityName: citiesName[cityIndex], completion: { (city, success, errorMessage, error) in
                print(city as Any)
                print(errorMessage as Any)
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: .main) {
            semaphore.signal()
        }
        
        _ = semaphore.wait(wallTimeout: .now() + 15)
    }
    
    func testDispatchGroupLoopWeatherRequest() {
        let semaphore = DispatchSemaphore(value: 0)
        let dispatchGroup = DispatchGroup()
        
        for city in citiesName {
            dispatchGroup.enter()
            realApi.getWeather(withCityName: city) { (city, success, errorMessage, error) in
                print(city as Any)
                print(errorMessage as Any)
                dispatchGroup.leave()
            }
        }
       
        dispatchGroup.notify(queue: .main) {
            semaphore.signal()
        }
        
        _ = semaphore.wait(wallTimeout: .now() + 15)
    }

}
