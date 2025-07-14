import XCTest
import SwiftTreeSitter
import TreeSitterTxtar

final class TreeSitterTxtarTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_txtar())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading Txtar grammar")
    }
}
