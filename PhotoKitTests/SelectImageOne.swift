//
//  ContentView.swift
//  PhotoKitTests
//
//  Created by TIEN DO on 4/11/24.
//

import PhotosUI
import SwiftUI

enum ImageStatus {
  case loading
  case success(Image)
  case failed(Error)
}

enum ImageError: Error {
  case notSupportedContentType
  case unknown
}

// Ref: https://www.hackingwithswift.com/books/ios-swiftui/loading-photos-from-the-users-photo-library
struct SelectImageOne: View {
  @State var status: ImageStatus = .loading
  // @State var selectedItems: [PhotosPickerItem] = []
  @State var selectedItem: PhotosPickerItem? = nil

  var body: some View {
    switch status {
      case .success(let image):
        image.resizable()
          .scaledToFit()
          .frame(height: 200)
      case .failed:
        Image(systemName: "exclamationmark.triangle.fill")
      default:
        ProgressView()
    }

    // PhotosPicker(selection: $selectedItems, maxSelectionCount: 5, matching: .images, preferredItemEncoding: .current, photoLibrary: .shared()) {
    PhotosPicker(selection: $selectedItem, matching: .images, preferredItemEncoding: .current, photoLibrary: .shared()) {
      Label("Select", systemImage: "photo")
    }
    .photosPickerAccessoryVisibility(.hidden, edges: [.bottom])
    .ignoresSafeArea()
    .buttonStyle(.borderedProminent)
    .onChange(of: selectedItem) {
      Task {
        do {
          if let result = try await selectedItem?.loadTransferable(type: Data.self), let uiImage = UIImage(data: result) {
            status = .success(Image(uiImage: uiImage))
          } else {
            throw ImageError.notSupportedContentType
          }
        } catch {
          status = .failed(error)
        }
      }
    }
  }
/*
  func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
    return imageSelection.loadTransferable(type: Image.self) { result in
      DispatchQueue.main.async {
        guard imageSelection == self.imageSelection else { return }
        switch result {
          case .success(let image?):
            // Handle the success case with the image.
          case .success(nil):
            // Handle the success case with an empty value.
          case .failure(let error):
            // Handle the failure case with the provided error.
        }
      }
    }
  }*/
}

#Preview {
  SelectImageOne()
}
