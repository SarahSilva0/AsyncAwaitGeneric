//
//  Client.swift
//  AWAIT
//
//  Created by Sarah dos Santos Silva on 01/12/23.
//

import Foundation

final class Client: GenericApi {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
}
