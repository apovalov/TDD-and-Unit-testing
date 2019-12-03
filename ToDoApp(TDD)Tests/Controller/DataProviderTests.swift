//
//  DataProviderTests.swift
//  ToDoApp_TDDTests
//
//  Created by Macbook on 03.12.2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import XCTest
@testable import ToDoApp_TDD

class DataProviderTests: XCTestCase {

    var sut: DataProvider!
    var tableView: UITableView!
    
    override func setUp() {
        sut = DataProvider()
        sut.taskManager = TaskManager()
        tableView = UITableView()
        tableView.dataSource = sut
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }
    
    func testNumberOfSectionsIsTwo() {
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    
    
    func testNumberOfRowsInSectionZeroIsTaskCount() {
        sut.taskManager?.add(task: Task(title: "Foo"))
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.taskManager?.add(task: Task(title: "Bar"))
        
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testNumberOfRowsInSectionOneIsDoneTaskCount() {
        
        sut.taskManager?.add(task: Task(title: "Foo"))
        sut.taskManager?.add(task: Task(title: "Bar"))
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0)
        
        sut.taskManager?.checkTask(at: 0)
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)

        sut.taskManager?.checkTask(at: 0)
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func testCellForRowAtIndexPathReturnsTaskCell() {
        sut.taskManager?.add(task: Task(title: "Foo"))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        
        XCTAssertTrue(cell is TaskCell)
    }
}
