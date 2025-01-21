import SwiftUI
import MijickCamera

struct CapturePhotoView: View {
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
      MCamera()
        .setCameraOutputType(.photo)
        .setAudioAvailability(false)
        .setResolution(.photo)
        .setCameraHDRMode(.off)
        // .setFocusImage(UIImage(systemName: "viewfinder")!) // can config symbol for thin style?
        .setFocusImage(UIImage(named: "Viewfinder")!)
        .setFocusImageColor(.yellow)
        .setFocusImageSize(80)
        .setCameraScreen {
          DefaultCameraScreen(cameraManager: $0, namespace: $1, closeMCameraAction: $2)
            .cameraOutputSwitchAllowed(false)
            .cameraPositionButtonAllowed(false)
        }
        .setCapturedMediaScreen(nil)
        .setCloseMCameraAction(onCloseCamera)
        .lockCameraInPortraitOrientation(AppDelegate.self)
        .onImageCaptured(onImageCaptured)
        .startSession()
    }
  }
}

extension CapturePhotoView {
  func onImageCaptured(image: UIImage, controller: MCamera.Controller) {
    print("Captured an image")
    capturedImage = image
    controller.closeMCamera() // will call onCloseCamera
  }

  func onCloseCamera() {
    print("Closed camera")
    isCameraPresented = false
  }
}

#Preview {
  CapturePhotoView()
}
