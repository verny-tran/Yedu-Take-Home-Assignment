//
//  YeduApp.swift
//  Yedu
//
//  Created by Trần T. Dũng  on 23/06/2022.
//

import SwiftUI

@main
struct YeduApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
