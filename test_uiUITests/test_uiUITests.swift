//
//  test_uiUITests.swift
//  test_uiUITests
//
//  Created by Dimas on 26.12.2019.
//  Copyright © 2019 T.D.V.DG. All rights reserved.
//

import XCTest

class test_uiUITests: XCTestCase {

	var app: XCUIApplication!

	
    override func setUp() {
		super.setUp()
        continueAfterFailure = false
		app = XCUIApplication()
		 app.launchArguments.append("--uitesting")

	}

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLayout() {
        app.launch()
		let likeButton = app.buttons["LikeIdentifier"].firstMatch;
		
		XCTAssert(likeButton.exists, "Like Button not exist")
		XCTAssert(likeButton.frame.origin.x == 10 && likeButton.frame.size == CGSize(width: 34, height: 34), "Like Button frame wrong:\(likeButton.frame)")
		
		let avatarImage = app.images ["UserAvatar"].firstMatch;
		
		XCTAssert(avatarImage.exists, "Like Button not exist")
		XCTAssert(avatarImage.frame.origin.x == 10 && avatarImage.frame.size == CGSize(width: 34, height: 34) && avatarImage.frame.origin.y < likeButton.frame.origin.y, "Like Button frame wrong:\(avatarImage.frame)")
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
				app.launch()
            }
        }
    }
}
