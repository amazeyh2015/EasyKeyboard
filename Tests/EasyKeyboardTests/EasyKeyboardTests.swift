import XCTest
@testable import EasyKeyboard

final class EasyKeyboardTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(EasyKeyboard().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
