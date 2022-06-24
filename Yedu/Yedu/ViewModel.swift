//
//  ViewModel.swift
//  Yedu
//
//  Created by Trần T. Dũng  on 23/06/2022.
//

import Foundation

final class ViewModel: ObservableObject {
    
    @Published var hasError = false
    @Published var error: UserError?
    
    @Published var users: [User] = []
    @Published private(set) var isRefreshing = false
    
    
    func fetchUsers() {
        
        hasError = false
        isRefreshing = true
        
        //                               🔗 Working JSON link
        //                                        |
        //                   --------------------------------------------
        let usersUrlString = "https://jsonplaceholder.typicode.com/users"   // The API provided: https://dummyapi.io/data/v1/user/62b291fd2191a308ab5a5f9c is not working!?
        if let url = URL(string: usersUrlString) {
            
            URLSession
                .shared
            //           ✳️ Common JSON handling MVVM architecture
            //                              |
            //  -----------------------------------------------------------
                .dataTask(with: url) { [weak self] data, response, error in
                    
                    DispatchQueue.main.async {
                        defer {
                            self?.isRefreshing = false
                        }
                        
                        if let error = error {
                            self?.hasError = true
                            self?.error = UserError.custom(error: error)
                        } else {
                            
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase // 😎 Handle properties that look like first_name > firstName
                            
                            if let data = data,
                               let users = try? decoder.decode([User].self, from: data) {
                                self?.users = users
                            } else {
                                self?.hasError = true
                                self?.error = UserError.failedToDecode
                            }
                        }
                    }
                }
                .resume()
        }
    }
}

extension ViewModel {
    enum UserError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode"   // ‼️ Decoding JSON file failure alert
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
