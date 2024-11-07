//
//  PhotoKitTestsApp.swift
//  PhotoKitTests
//
//  Created by TIEN DO on 4/11/24.
//

import SwiftUI
import SwiftData

@main
struct PhotoKitTestsApp: App {
  /*var sharedModelContainer: ModelContainer = {
    let schema = Schema([
      Item.self,
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()*/

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    //.modelContainer(sharedModelContainer)
  }

  init() {
    print("applicationSupportDirectory: \(URL.applicationSupportDirectory.path())")
    print("documentsDirectory: \(URL.documentsDirectory.path())")
  }
}
