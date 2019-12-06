//
//  DetailViewControllerTest.swift
//  ToDoApp_TDDTests
//
//  Created by Macbook on 05.12.2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDoApp_TDD

class DetailViewControllerTest: XCTestCase {

    var sut: DetailViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: String(describing: DetailViewController.self)) as? DetailViewController
        sut.loadViewIfNeeded()    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testHasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertNotNil(sut.titleLabel.isDescendant(of: sut.view))
    }
    
    
    func testHasDescriptionLabel() {
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertNotNil(sut.descriptionLabel.isDescendant(of: sut.view))
    }


    func testHasDateLabel() {
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertNotNil(sut.dateLabel.isDescendant(of: sut.view))
    }
    
    func testHasMapView() {
        XCTAssertNotNil(sut.mapView)
        XCTAssertNotNil(sut.mapView.isDescendant(of: sut.view))
    }
    
    func testHasLocationView() {
        XCTAssertNotNil(sut.locationLabel)
        XCTAssertNotNil(sut.locationLabel.isDescendant(of: sut.view))
    }

    func setupTaskAndAppearanceransition() {
        let coordinate = CLLocationCoordinate2D(latitude: 40.755931, longitude: -73.984606)
        let date = Date(timeIntervalSince1970: 4415299200)
        let location = Location(name: "Baz",
        coordinate: coordinate)
        let task = Task(title: "Foo",
                        description: "Bar",
                        date: date,
                        location: location)
        sut.task = task
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
    }
    
    func testSettingTaskSetsTitleLabel() {
        setupTaskAndAppearanceransition()
        XCTAssertEqual(sut.titleLabel.text, "Foo")
    }
    
    func testSettingTaskSetsDescriptionLabel() {
        setupTaskAndAppearanceransition()
        XCTAssertEqual(sut.descriptionLabel.text, "Bar")
    }
    
    
    func testSettingTaskSetsLocationLabel() {
        setupTaskAndAppearanceransition()
        XCTAssertEqual(sut.locationLabel.text, "Baz")
    }
    
    
    func testSettingTaskSetsDateLabel() {
        setupTaskAndAppearanceransition()
        XCTAssertEqual(sut.dateLabel.text, "01.12.09")
    }
    
    
    func testSettingTaskSetsMapView() {
        setupTaskAndAppearanceransition()
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude,
                       40.755931,
                       accuracy: 0.001)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude,
                       -73.984606,
                       accuracy: 0.001)
    }
}
