//
//  main.swift
//  StubServer
//

import HeliumLogger
import Foundation
import Kitura

 
// Disable buffering
setbuf(stdout, nil)
 
// setup routes
let stubServer = StubServer(port: 8091, logger: HeliumLogger())
stubServer.run()
