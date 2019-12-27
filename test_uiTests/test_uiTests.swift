//
//  test_uiTests.swift
//  test_uiTests
//
//  Created by Dimas on 26.12.2019.
//  Copyright © 2019 T.D.V.DG. All rights reserved.
//

import XCTest
@testable import test_ui

class test_uiTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func testDataProvider(){
		let provider = DataProvider(from: Bundle.main.path(forResource: "data", ofType: "json")!)
		let waiter = XCTWaiter()
		let expeaction = XCTestExpectation()
		provider.getPosts { (posts) in
			
			XCTAssert(posts.count == 2, "FAILED LOAD DATA")
			expeaction.fulfill()
			
		}
		waiter.wait(for: [expeaction],timeout: 60)
	}
	
	func testEncodeDecodePost(){
		let date = Date()
		
		let json = """
        {
		"userName":"DimasSup",
		"userAvatarLink":"http://avatars.design/wp-content/uploads/2016/09/avatar1b.jpg",
		"postLocation" : "Kharkiv, Somewhere",
		"contentLinks" : [
		"https://i.ytimg.com/vi/BHACKCNDMW8/maxresdefault.jpg"
		],
		"likesCount": 10,
		"commentsCount": 2,
		"friendsLikes": ["Maxim"],
		"title":"What @you think?\\n#somewhere #nature",
		"date":"\(CodableHelper.defaultDateFormat.string(from: date))"
	}
"""
		let item:PostItem? = CodableHelper.decode(json.data(using: .utf8)!)
		XCTAssertNotNil(item)
		if let item = item{
			XCTAssert(item.userName == "DimasSup","FAILED DECODE NAME")
			
			let container = PostsContainer(posts: [item])
			let containerData = try?  CodableHelper.encode(container)
			XCTAssertNotNil(containerData,"Failed encode container")
			let containerString = String(data: containerData!, encoding: .utf8)
			XCTAssertNotNil(containerString,"Failed convert container data to String")
			
			
			
			let result = CodableHelper.encode(item)
			XCTAssertNotNil(result)
			if let json = try? JSONSerialization.jsonObject(with: result!, options: .init(rawValue: 0)) as? [AnyHashable:Any]{
				XCTAssert(json["userName"] as? String == "DimasSup","FAILED ENCODE")
			}
			else{
				XCTFail("Can't parse encoded json")
			}
			
		}
	}
	
    func testMessageAttributedString() {
		let userName = "DimasSup"
		let message = "Hello #darkness, my old @friend. I've come to talk with @you"
		let attributes = StringsHelper.defaultMessageStyle
		let attributedString = try? StringsHelper.makeMessageAttributeString(userName, text: message)
		XCTAssertNotNil(attributedString)
		if let attributedString = attributedString{
			XCTAssert(attributedString.attributes(at: 0, effectiveRange: nil)[.foregroundColor] as? UIColor == attributes[.UserColor] as? UIColor,"NO USER NAME COLOR:\n\(attributedString)")
			XCTAssert(attributedString.attributes(at: attributedString.length - 1, effectiveRange: nil)[.foregroundColor] as? UIColor == attributes[.TagColor] as? UIColor,"NO TAG COLOR:\n\(attributedString)")
		}
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
