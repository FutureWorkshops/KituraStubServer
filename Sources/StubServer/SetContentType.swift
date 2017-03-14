//
//  ContentType.swift
//  StubServer
//

import Foundation
import Kitura

class SetContentType: RouterMiddleware {
    let contentType: String

    init(_ type: String) {
        self.contentType = type
    }

    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        response.headers["Content-Type"] = (self.contentType)
    }
}
