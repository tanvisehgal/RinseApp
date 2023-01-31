

import XCTest

class RinseTests: XCTestCase {

    func testNotificationIDCreation() {
        let first = "123_abcc"
        let second = "456_def"
        XCTAssertNotEqual(first, second)
    }

//    func testNotificationIDCreationFailure() {
//        let first = "123_abcc"
//        let second = "456_def"
//        XCTAssertEqual(first, second)
//    }

}
