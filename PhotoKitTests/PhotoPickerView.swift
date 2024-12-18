//
//  PhotoPickerView.swift
//  PhotoKitTests
//
//  Created by TIEN DO on 18/12/24.
//

import PhotosUI
import SwiftUI

// Ref: https://www.kodeco.com/36653975-what-s-new-with-photospicker-in-ios-16
// Ref: https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-select-pictures-using-photospicker
struct PhotoPickerView: View {
  @State var selectedPhotoItem: PhotosPickerItem?
  @State var imageData: Data? = nil

  var body: some View {
    VStack {
      Spacer()
      if let imageData {
        Image(uiImage: .init(data: imageData)!)
          .resizable()
          .scaledToFit()
          .clipShape(.rect(cornerRadius: 5))
          .padding()
      }
      Spacer()
      PhotosPicker(selection: $selectedPhotoItem, matching: .images, preferredItemEncoding: .current, photoLibrary: .shared()) {
        Label("Photos", systemImage: "photo")
      }
      .photosPickerAccessoryVisibility(.hidden, edges: [.bottom])
      .ignoresSafeArea()
      .buttonStyle(.bordered)
    }
    .task(id: selectedPhotoItem) {
      if let selectedPhotoItem {
        // print("selectedPhotoItem ID: \(selectedPhotoItem.itemIdentifier ?? "")")
        // selectedImage = try? await selectedPhotoItem.loadTransferable(type: Image.self)
        imageData = try? await selectedPhotoItem.loadTransferable(type: Data.self)
      }
    }
  }
}

#Preview {
  PhotoPickerView()
}
