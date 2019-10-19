import Foundation

public struct Resource {
  public let name: String
  public let type: String
  public let url: URL

  public init(name: String, type: String, sourceFile: StaticString = #file) throws {
    self.name = name
    self.type = type

    // The following assumes that your test source files are all in the same directory, and the resources are one directory down and over
    // <Some folder>
    //  - Resources
    //      - <resource files>
    //  - <Some test source folder>
    //      - <test case files>
    let testCaseURL = URL(fileURLWithPath: "\(sourceFile)", isDirectory: false)
    let testsFolderURL = testCaseURL.deletingLastPathComponent()
    let resourcesFolderURL = testsFolderURL.deletingLastPathComponent().appendingPathComponent("Resources", isDirectory: true)
    self.url = resourcesFolderURL.appendingPathComponent("\(name).\(type)", isDirectory: false)
  }
}


public extension Resource {
    var content: String? {
        return try? String(contentsOfFile: url.path).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    var data: Data? {
        try? Data(contentsOf: url)
    }
}
