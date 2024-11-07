//
//  DownloadManager.swift
//  PhotoKitTests
//
//  Created by TIEN DO on 7/11/24.
//
import Foundation

@Observable
class DownloadManager {
  var isDownloading = false

  func downloadFile() {
    isDownloading = true

    let destinationUrl = URL.documentsDirectory.appendingPathComponent("test.jpg", conformingTo: .jpeg)

    if FileManager.default.fileExists(atPath: destinationUrl.path()) {
      print("\(destinationUrl) exists")
      isDownloading = false
    } else {}
  }
}
