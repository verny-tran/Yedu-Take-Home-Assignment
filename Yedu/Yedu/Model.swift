//
//  APIReponses.swift
//  Yedu
//
//  Created by Trần T. Dũng  on 24/06/2022.
//

import Foundation
import SwiftUI

//            🔍 Search    🫳 JSON
//                 |          |
//           ------------  -------
struct User: Identifiable, Codable {
    let id: Int
    let email: String
    let name: String
    let company: Company
}

//  🥵 This exists because of the original dead API
//            |
//     ----------------
struct Company: Codable {
    let name: String
}
