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
}
