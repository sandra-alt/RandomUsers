//
//  NetworkService.swift
//  RandomUsers
//
//  Created by  Oleksandra on 1/21/19.
//  Copyright © 2019 sandra-alt. All rights reserved.
//

import Foundation

class NetworkService {
    
    fileprivate let session = URLSession(configuration: .default)
    private let baseURLString = "https://randomuser.me/api/?results=20&seed=abc&exc=login,registered,id,nat"
    
    func fetchUsers(completion: @escaping([User]?) -> Void){
        self.fetchUsers(forPage: 1, completion: (completion))
    }
    
    func fetchUsers(forPage page: Int, completion: @escaping([User]?) -> Void){
        let url = URL(string: baseURLString + "&page=\(page)")
        
        let task = session.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let jsonData = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let decoded = try decoder.decode(UsersArray.self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(decoded.results)
                    }
                } catch {
                    print("Problem parsing JSON: \(error)")
                }
            }
        }
        task.resume()
    }
    
    fileprivate struct UsersArray: Decodable {
        let results: [User]
    }
}
