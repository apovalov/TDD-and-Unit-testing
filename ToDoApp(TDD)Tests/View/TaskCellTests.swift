//
//  TaskCellTests.swift
//  ToDoApp_TDDTests
//
//  Created by Macbook on 04.12.2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import XCTest
@testable import ToDoApp_TDD

class TaskCellTests: XCTestCase {
    
    var cell: TaskCell!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self)) as! TaskListViewController
        controller.loadViewIfNeeded()
        
        let tableView = controller.tableView
        let dataSource = FakeDataSource()
        tableView?.dataSource = dataSource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: IndexPath(row: 0, section: 0 )) as? TaskCell
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCellHasTitleLabel() {
        XCTAssertNotNil(cell.titleLabel)
    }
    
    func testCellHasTitleLabelInContentView() {
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    
    func testCellHasLocationLabel() {
        XCTAssertNotNil(cell.locationLabel)
    }
    
    func testCellHasLocationLabelInContentView() {
        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
    }
    
    func testCellHasDateLabel() {
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func testCellHasDateLabelInContentView() {
        XCTAssertTrue(cell.dateLabel.isDescendant(of: cell.contentView))
    }
    
    func testConfigureSetsTitle() {
        let task = Task(title: "Foo")
        cell.configure(withTask: task)
        XCTAssertEqual(cell.titleLabel.text, task.title)
    }
    
    func testConfigureSetsDate() {
        let task = Task(title: "Foo")
        cell.configure(withTask: task)
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        let date = task.date
        let dateString = df.string(from: date)
        
        XCTAssertEqual(cell.dateLabel.text, dateString)
    }
    
    func testConfigureSetsLocation() {
        let task = Task(title: "Foo", description: "Bar", location: Location(name: "Rostov"))
        cell.configure(withTask: task)
        XCTAssertEqual(cell.locationLabel.text, task.location?.name)
    }
    
    func configureCellWithTask() {
        let task = Task(title: "Foo")
        cell.configure(withTask: task, done: true)
    }
    
    func testDoneTaskShouldStrikeThrough() {
        configureCellWithTask()
        
        let attributeString = NSAttributedString(string: "Foo", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        XCTAssertEqual(cell.titleLabel.attributedText, attributeString)
    }
    
    
    func testDoneTaskDateLabelEqualsNil() {
        configureCellWithTask()
        XCTAssertNil(cell.dateLabel)
    }
    
    func testDoneTaskLocationLabelEqualsNil() {
        configureCellWithTask()
        XCTAssertNil(cell.locationLabel)
    }
}

extension TaskCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
