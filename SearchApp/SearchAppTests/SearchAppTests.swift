//
//  SearchAppTests.swift
//  SearchAppTests
//
//  Created by Nagib Azad on 23/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import XCTest

class SearchAppTests: XCTestCase {

    var sessionUnderTest: URLSession!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sessionUnderTest = URLSession(configuration: .default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
        super.tearDown()
    }

    func testValidityOfWikipediaApi() {
        // given
        let url = URL(string: "https://en.wikipedia.org/w/api.php?action=query&generator=search&gsrlimit=20&gsroffset=0&gsrsearch=Car&utf8=&format=json&prop=info%7Cpageimages&inprop=url")

        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 7) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
