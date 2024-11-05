//
//  SelectImageTwo.swift
//  PhotoKitTests
//
//  Created by TIEN DO on 5/11/24.
//

import PhotosUI
import SwiftUI

struct TransferableImage: Transferable {
  let image: Image

  static var transferRepresentation: some TransferRepresentation {
    DataRepresentation(importedContentType: .image) { data in
      guard let uiImage = UIImage(data: data) else {
        throw ImageError.notSupportedContentType
      }

      return TransferableImage(image: Image(uiImage: uiImage))
    }
  }
}

struct SelectImageTwo: View {
  @State var status: ImageStatus = .loading
  @State var selectedItem: PhotosPickerItem? = nil

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
            } else {
              status = .failed(ImageError.unknown)
            }

          case .failure(let error):
            status = .failed(error)
        }
      }
    }
  }
}

#Preview {
  SelectImageTwo()
}
