//
//  URL+Resources.swift
//  StubServer
//

import Foundation

extension URL {
    static var sourcesRootPath: URL {
        get {
            var currentFilePath = URL(fileURLWithPath: #file)
            currentFilePath.deleteLastPathComponent() // filename
            currentFilePath.deleteLastPathComponent() // StubServer
            currentFilePath.deleteLastPathComponent() //Sources
            return currentFilePath
        }
    }

    static var viewsPath: URL {
        get {
            var viewsFilePath = URL.sourcesRootPath
            viewsFilePath.appendPathComponent("Views")

            return viewsFilePath
        }
    }
}
