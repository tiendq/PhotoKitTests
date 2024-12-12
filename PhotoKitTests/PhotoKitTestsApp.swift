//
//  PhotoKitTestsApp.swift
//  PhotoKitTests
//
//  Created by TIEN DO on 4/11/24.
//

import SwiftUI
import SwiftData
import MijickCameraView

// Disable camera UI rotation (but not affect captured image)
// Ref: https://github.com/Mijick/CameraView#5-optional-block-screen-rotation-for-mcameracontroller
class AppDelegate: NSObject, MApplicationDelegate {
  static var orientationLock = UIInterfaceOrientationMask.all
  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask { AppDelegate.orientationLock }
}

@main
struct PhotoKitTestsApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
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
