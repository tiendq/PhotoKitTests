//
//  PhotoKitTestsApp.swift
//  PhotoKitTests
//
//  Created by TIEN DO on 4/11/24.
//

import SwiftUI
import SwiftData
import MijickCamera

// Disable camera UI rotation (but not affect captured image).
// Ref: https://github.com/Mijick/Camera/issues/70
class AppDelegate: NSObject, MApplicationDelegate {
  static var orientationLock = UIInterfaceOrientationMask.all
  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask { AppDelegate.orientationLock }
}

@main
struct PhotoKitTestsApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }

  init() {
    // print("applicationSupportDirectory: \(URL.applicationSupportDirectory.path())")
    print("documentsDirectory: \(URL.documentsDirectory.path())")
  }
}
