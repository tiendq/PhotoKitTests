import SwiftUI
import MijickCameraView

struct CapturePhotoView: View {
  @State var manager: CameraManager = .init(
    // hdrMode: CameraHDRMode.off, // error https://github.com/Mijick/CameraView/issues/68
    resolution: .photo,
    focusImage: UIImage(systemName: "square.dashed"), // Issue: not square https://github.com/Mijick/CameraView/issues/69
    focusImageColor: .yellow,
    focusImageSize: 90
  )

  @State var isCameraPresented = false
  @State var capturedImage: UIImage? = nil

  var body: some View {
    VStack {
      if let capturedImage {
        Image(uiImage: capturedImage)
          .resizable()
          .scaledToFit()
          .frame(height: 200)
          .padding([.bottom], 20)
      }
      Button("Camera") {
        isCameraPresented = true
      }
    }
    .fullScreenCover(isPresented: $isCameraPresented) {
      MCameraController(manager: manager)
        .cameraScreen {
          // Change default camera view (with on/off options)
          // Ref: https://github.com/Mijick/CameraView/issues/33
          DefaultCameraView(cameraManager: $0, namespace: $1, closeControllerAction: $2)
            .cameraPositionButtonVisible(false)
            .flipButtonVisible(false)
            .outputTypePickerVisible(false)
        }
        .mediaPreviewScreen(nil)
        .lockOrientation(AppDelegate.self)
        .onImageCaptured(onImageCaptured)
        .onCloseController(onCloseController)
        .afterMediaCaptured {
          $0.closeCameraController(true)
        }
    }
  }
}

extension CapturePhotoView {
  func onImageCaptured(_ image: UIImage) {
    print("Captured an image")
    capturedImage = image
  }

  func onCloseController() {
    isCameraPresented = false
  }

  func afterMediaCaptured() {
    isCameraPresented = false
  }
}

#Preview {
  CapturePhotoView()
}