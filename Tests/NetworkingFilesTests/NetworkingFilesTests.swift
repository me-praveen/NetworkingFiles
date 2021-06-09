import XCTest
@testable import NetworkingFiles

final class NetworkingFilesTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(NetworkingFiles().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
