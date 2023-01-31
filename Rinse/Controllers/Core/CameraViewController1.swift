
//
//import AVFoundation
//import UIKit
//
///// Controller to handle taking pictures or choosing from Library
//final class CameraViewController1: UIViewController {
//
//    private var output = AVCapturePhotoOutput()
//    //    private var captureSession: AVCaptureSession?
////    private let previewLayer = AVCaptureVideoPreviewLayer()
//    var previewLayer : AVCaptureVideoPreviewLayer!
//    private var cameraFront = false
//    private let cameraView = UIView()
//    let captureSession = AVCaptureSession()
//
//    var backCamera : AVCaptureDevice!
//    var frontCamera : AVCaptureDevice!
//    var backInput : AVCaptureInput!
//    var frontInput : AVCaptureInput!
//
//    private let shutterButton: UIButton = {
//        let button = UIButton()
//        button.layer.masksToBounds = true
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.label.cgColor
//        button.backgroundColor = nil
//        return button
//    }()
//
//    //    private let photoPickerButton: UIButton = {
//    //        let button = UIButton()
//    //        button.tintColor = .label
//    //        button.setImage(UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)),
//    //                        for: .normal)
//    //        return button
//    //    }()
//
//    private let flipCameraButton: UIButton = {
//        let button = UIButton()
//        button.tintColor = .label
//        button.setImage(UIImage(systemName: "arrow.triangle.2.circlepath.camera", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)),
//                        for: .normal)
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .secondarySystemBackground
//        title = "Take Photo"
//        view.addSubview(cameraView)
//        view.addSubview(shutterButton)
//        //        view.addSubview(photoPickerButton)
//        view.addSubview(flipCameraButton)
//        setUpNavBar()
////        checkCameraPermission()
//        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
//        //        photoPickerButton.addTarget(self, action: #selector(didTapPickPhoto), for: .touchUpInside)
//        flipCameraButton.addTarget(self, action: #selector(didTapFlipCamera), for: .touchUpInside)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        tabBarController?.tabBar.isHidden = true
//        //        if let session = captureSession, !session.isRunning {
//        if !captureSession.isRunning {
//            print("DEBUG: capture session not running in view did appear")
////            setUpCamera()
//            //            captureSession.startRunning()
//        }
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        captureSession.stopRunning()
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        cameraView.frame = view.bounds
////        previewLayer.frame = CGRect(
////            x: 0,
////            y: view.safeAreaInsets.top,
////            width: view.width,
////            height: view.width
////        )
//
//        let buttonSize: CGFloat = view.width/5
//        shutterButton.frame = CGRect(
//            x: (view.width-buttonSize)/2,
//            y: view.safeAreaInsets.top + view.width + 100,
//            width: buttonSize,
//            height: buttonSize
//        )
//        shutterButton.layer.cornerRadius = buttonSize/2
//
//        //        photoPickerButton.frame = CGRect(x: (shutterButton.left - (buttonSize/1.5))/2,
//        //                                         y: shutterButton.top + ((buttonSize/1.5)/2),
//        //                                         width: buttonSize/1.5,
//        //                                         height: buttonSize/1.5)
//        flipCameraButton.frame = CGRect(x: (shutterButton.right + (buttonSize/1.5)),
//                                        y: shutterButton.top + ((buttonSize/1.5)/2),
//                                        width: buttonSize/1.5,
//                                        height: buttonSize/1.5)
//
//    }
//
////    @objc func didTapPickPhoto() {
////        let picker = UIImagePickerController()
////        picker.sourceType = .photoLibrary
////        picker.allowsEditing = true
////        picker.delegate = self
////        present(picker, animated: true)
////    }
//
//    @objc func didTapTakePhoto() {
//        output.capturePhoto(with: AVCapturePhotoSettings(),
//                            delegate: self)
//    }
//
//    @objc func didTapFlipCamera() {
//        // to do
//        cameraFront = !cameraFront
//
////        setUpCamera()
//    }
//
//    private func setupAndStartCaptureSession() {
//        DispatchQueue.global(qos: .userInitiated).async {
//            //init session
//            //            self.captureSession = AVCaptureSession()
//            //start configuration
//            self.captureSession.beginConfiguration()
//
//            //session specific configuration
//            //before setting a session presets, we should check if the session supports it
//            if self.captureSession.canSetSessionPreset(.photo) {
//                self.captureSession.sessionPreset = .photo
//            }
//            self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
//
//            //setup inputs
//            self.setupInputs()
//
//            DispatchQueue.main.async {
//                //setup preview layer
//                self.setupPreviewLayer()
//            }
//
//            //commit configuration
//            self.captureSession.commitConfiguration()
//            //start running it
//            self.captureSession.startRunning()
//        }
//    }
//
//    private func setupPreviewLayer(){
//            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//            view.layer.insertSublayer(previewLayer, below: flipCameraButton.layer)
//            previewLayer.frame = self.view.layer.frame
//        }
//
//    private func setupInputs(){
//            //get back camera
//            if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
//                backCamera = device
//            } else {
//                //handle this appropriately for production purposes
//                fatalError("no back camera")
//            }
//
//            //get front camera
//            if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
//                frontCamera = device
//            } else {
//                fatalError("no front camera")
//            }
//
//            //now we need to create an input objects from our devices
//            guard let bInput = try? AVCaptureDeviceInput(device: backCamera) else {
//                fatalError("could not create input device from back camera")
//            }
//            backInput = bInput
//            if !captureSession.canAddInput(backInput) {
//                fatalError("could not add back camera input to capture session")
//            }
//
//            guard let fInput = try? AVCaptureDeviceInput(device: frontCamera) else {
//                fatalError("could not create input device from front camera")
//            }
//            frontInput = fInput
//            if !captureSession.canAddInput(frontInput) {
//                fatalError("could not add front camera input to capture session")
//            }
//
//            //connect back camera input to session
//            captureSession.addInput(backInput)
//        }
//
////    private func checkCameraPermission() {
////        print("DEBUG: in permission")
////        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
////        case .notDetermined:
////            // request
////            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
////                guard granted else {
////                    return
////                }
////                DispatchQueue.main.async {
////                    self?.setUpCamera()
////                }
////            }
////        case .authorized:
////            setUpCamera()
////        case .restricted, .denied:
////            break
////        @unknown default:
////            break
////        }
////    }
////
////    private func getFrontCamera() -> AVCaptureDevice?{
////        return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)!
////    }
////
////    func getBackCamera() -> AVCaptureDevice{
////        return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!
////    }
////
////    private func setUpCamera() {
////        print("DEBUG: in set up camera")
////        if captureSession.isRunning {
////            print("DEBUG: Capture Session is Running in SetUpCamera")
////            captureSession.beginConfiguration()
////            let currentInput : AVCaptureInput = captureSession.inputs[0]
////            captureSession.removeInput(currentInput)
////            print("DEBUG: removing current input")
////
////            if let device = (cameraFront ? getFrontCamera() : getBackCamera()) {
////                do {
////                    let input = try AVCaptureDeviceInput(device: device)
////                    if captureSession.canAddInput(input) {
////                        captureSession.addInput(input)
////                    }
////                }
////                catch {
////                    print(error)
////                }
////            }
////            captureSession.commitConfiguration()
////        }
////
////        else {
////            //        if let device = AVCaptureDevice.default(for: .video) {
////            if let device = (cameraFront ? getFrontCamera() : getBackCamera()) {
////                do {
////                    let input = try AVCaptureDeviceInput(device: device)
////                    if captureSession.canAddInput(input) {
////                        captureSession.addInput(input)
////                    }
////                }
////                catch {
////                    print(error)
////                }
////
////                if captureSession.canAddOutput(output) {
////                    captureSession.addOutput(output)
////                }
////                print("DEBUG: in else set up camera")
////                // Layer
////                //                previewLayer.session = captureSession
////                //                previewLayer.videoGravity = .resizeAspectFill
////                //                cameraView.layer.addSublayer(previewLayer)
////                //init session
////                //start configuration
////                self.captureSession.beginConfiguration()
////
////                //do some configuration?
////
////                //commit configuration
////                self.captureSession.commitConfiguration()
////                //start running it
////                captureSession.startRunning()
////            }
////        }
////
////
////    }
//
//    @objc func didTapClose() {
//        tabBarController?.selectedIndex = 0
//        tabBarController?.tabBar.isHidden = false
//    }
//
//    private func setUpNavBar() {
//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .close,
//            target: self,
//            action: #selector(didTapClose)
//        )
//    }
//}
//
//extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
//            return
//        }
//        showEditPhoto(image: image)
//    }
//}
//
//extension CameraViewController: AVCapturePhotoCaptureDelegate {
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//        guard let data = photo.fileDataRepresentation(),
//              var image = UIImage(data: data) else {
//            return
//        }
//        captureSession.stopRunning()
//        if cameraFront {
//            image = UIImage(cgImage: image.cgImage!, scale: 1, orientation: .leftMirrored)
//        }
//        showEditPhoto(image: image)
//    }
//
//    private func showEditPhoto(image: UIImage) {
//        guard let resizedImage = image.sd_resizedImage(
//            with: CGSize(width: 640, height: 640),
//            scaleMode: .aspectFill
//        ) else {
//            return
//        }
//
//        let vc = PostEditViewController(image: resizedImage)
//        if #available(iOS 14.0, *) {
//            vc.navigationItem.backButtonDisplayMode = .minimal
//        }
//        navigationController?.pushViewController(vc, animated: false)
//
//    }
//}
