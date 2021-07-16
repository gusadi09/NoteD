//
//  NoteDApp.swift
//  NoteD
//
//  Created by Gus Adi on 14/07/21.
//

import SwiftUI

@main
struct NoteDApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}
