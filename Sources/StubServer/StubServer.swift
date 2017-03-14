//
//  StubServer.swift
//  StubServer
//

import Foundation
import Kitura
import LoggerAPI
import SwiftyJSON
import KituraStencil

class StubServer {
    let port: Int
    let logger: Logger?

    init(port: Int, logger: Logger?) {
        self.port = port
        self.logger = logger
    }

    func run() {
        let router = Router()

        Log.logger = self.logger
        
        router.all(middleware: BodyParser())
        router.setDefault(templateEngine: StencilTemplateEngine())

        self.configureRoutes(router: router)

        self.configureMiddleware(router: router)

        // Start server
        Log.info("Starting server")
        Kitura.addHTTPServer(onPort: self.port, with: router)
        Kitura.run()
        Log.info("Listening on port \(self.port)")
    }

}

extension StubServer {
    func configureRoutes(router: Router) {
        router.get("static_resource", handler: staticFileHandler(filePath: "static_resource.json"))
        router.get("resource/:id", handler: stencilFileHandler(templatePath: "resource_id"))
    }
}

extension StubServer {
    func configureMiddleware(router: Router) {
        router.all(middleware: SetContentType("application/json"))
    }
}



func staticFileHandler(filePath: String) -> RouterHandler {
    return { request, response, next in
        let fullFilePath = URL.viewsPath.appendingPathComponent(filePath)
        let data = try! Data(contentsOf: fullFilePath)
        response.status(.OK).send(data: data)
        Log.info("Serving request URL: \(request.urlURL.absoluteString) with file: \(fullFilePath)")
        next()
    }
}

func stencilFileHandler(templatePath: String) -> RouterHandler {
    return { request, response, next in
        let context = request.parameters

        try! response.status(.OK).render(templatePath, context:context)
        Log.info("Serving request URL: \(request.urlURL.absoluteString) with stencil template: \(templatePath)")
        next()
    }
}
