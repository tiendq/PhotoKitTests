//
//  SelectImageTwo.swift
//  PhotoKitTests
//
//  Created by TIEN DO on 5/11/24.
//

import PhotosUI
import SwiftUI
import UIKit

struct SaveImageView: View {
  @State var status: ImageStatus = .loading
  @State var selectedItem: PhotosPickerItem? = nil
  @State var imageFileUrl: URL? = nil
  @State var imageData: Data? = nil

  var body: some View {
    switch status {
      case .success(let image):
        image.resizable()
          .scaledToFit()
          .frame(height: 200)
      case .failed:
        Image(systemName: "exclamationmark.triangle.fill")
          .font(.largeTitle)
          .foregroundStyle(.red)
      default:
        ProgressView()
    }

    PhotosPicker(selection: $selectedItem, matching: .images, preferredItemEncoding: .current, photoLibrary: .shared()) {
      Text("Select")
    }
    .photosPickerAccessoryVisibility(.hidden, edges: [.bottom])
    .ignoresSafeArea()
    .buttonStyle(.borderedProminent)
    .onChange(of: selectedItem) {
      selectedItem?.loadTransferable(type: TransferableImage.self) { result in
        switch result {
          case .success(let transferableImage):
            if let transferableImage {
              status = .success(transferableImage.image)
              saveImage(content: transferableImage.data)
            } else {
              status = .failed(ImageError.unknown)
            }

          case .failure(let error):
            status = .failed(error)
        }
      }
    }

    if nil != imageFileUrl {
      if let imageData {
        Image(uiImage: .init(data: imageData)!)
          .resizable()
          .scaledToFit()
          .frame(height: 200)
      }
      Button("Show Image") {
        loadImage()
      }
      .buttonStyle(.borderedProminent)
    }
  }

  func saveImage(content: Data) {
    let fileName = UUID().uuidString
    let directory = URL.documentsDirectory.appendingPathComponent("202412", conformingTo: .directory)

    if false == FileManager.default.fileExists(atPath: directory.path()) {
      do {
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: false)
      } catch {
        print(error)
      }
    }

    let url = directory.appendingPathComponent("\(fileName).jpg", conformingTo: .jpeg)

    imageFileUrl = url
    print("Saving image at \(url.path())...")

    /*if FileManager.default.createFile(atPath: url.path(), contents: content) {
      print("Success")
    } else {
      print("Failed")
    }*/

    do {
      try content.write(to: url, options: .atomic)
    } catch {
      print(error)
    }
  }

  func loadImage() {
    if let imageFileUrl {
      imageData = try? Data(contentsOf: imageFileUrl)
    }
  }
}

#Preview {
  SaveImageView()
}
