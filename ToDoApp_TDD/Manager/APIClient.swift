//
//  APIClient.swift
//  ToDoApp_TDD
//
//  Created by Macbook on 05.12.2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case emptyData
}

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

class APIClient {
    lazy var urlSession: URLSessionProtocol = URLSession.shared
    
    func login(withName name: String, password: String, completionHandler: @escaping (String?, Error?) -> Void) {
        
        let allowedCharacters = CharacterSet.urlQueryAllowed
        
        guard let name = name.addingPercentEncoding(withAllowedCharacters: allowedCharacters),
            let password = password.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
                fatalError()
        }
        
        let query = "name=\(name)&password=\(password)"
        guard let url = URL(string: "https://todoapp.com/login?\(query)") else {
            fatalError()
        }
        urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            do {
                guard let data = data else {
                    completionHandler(nil, NetworkError.emptyData)
                    return }
                let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String:String]
                
                let token = dictionary["token"]
                completionHandler(token, nil)
            } catch {
                completionHandler(nil, error)
            }
        }.resume()
    }
}
