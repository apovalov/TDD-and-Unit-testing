//
//  TaskTests.swift
//  ToDoApp(TDD)Tests
//
//  Created by Macbook on 03.12.2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import XCTest
@testable import ToDoApp_TDD

class TaskTests: XCTestCase {

    func testInitTAskWithTitle() {
        let task = Task(title: "Foo")
        XCTAssertNotNil(task)
    }

    func testInitTAskWithTitleAndDescription() {
        let task = Task(title: "Foo", description: "Bar")
        XCTAssertNotNil(task)
    }
    
    func testWhenGivenDescriptionSetsTitle() {
        let task = Task(title: "Foo")
        XCTAssertEqual(task.title, "Foo")
    }
    
    func testWhenGivenDescriptionSetsDescription() {
        let task = Task(title: "Foo", description: "Description")
        XCTAssertEqual(task.description, "Description")
    }
    
    func testTaskInitsWithDate() {
        let task = Task(title: "Foo")
        XCTAssertNotNil(task.date)
    }
    
    
    func testWhenGivenLocationSetsDescription() {
        let location = Location(name: "Foo")
        
        let task = Task(title: "Bar",
                        description: "Baz",
                        location: location)
        
        XCTAssertEqual(task.location, location)
    }
    
    func testCanBeeCreatedFromPlistDictionary()  {
        let location = Location(name: "Baz")
        let date = Date(timeIntervalSince1970: 10)
        let task = Task(title: "Foo", description: "Bar", date: date, location: location)
        
        let locationDict: [String : Any] = ["name" : "Baz"]
        let dictionary: [String : Any] = ["title" : "Foo",
                                          "description" : "Bar",
                                          "date" : date,
                                          "location" : locationDict]
        let createdTask = Task(dict: dictionary)
        XCTAssertEqual(task, createdTask)
    }
    
    
    func testCanBeeSerializedIntoDictionary()  {
        let location = Location(name: "Baz")
        let date = Date(timeIntervalSince1970: 10)
        let task = Task(title: "Foo", description: "Bar", date: date, location: location)
        
        let generatedTask = Task(dict: task.dict)
        
        XCTAssertEqual(task, generatedTask)
        
    }
}

