//
//  ViewController.swift
//  Day52-54
//
//  Created by Mehmet Ateş on 21.02.2022.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!

    @IBOutlet var intensity: UISlider!
    @IBOutlet var radiusSlider: UISlider!
    @IBOutlet var scaleSlider: UISlider!
    
    var currentImage: UIImage!
    
    var context: CIContext!
    var currentFilter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(takeImage))
        
        title = "SEPIA"
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
        imageView.alpha = 0
        // Do any additional setup after loading the view.
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    
    @objc func takeImage(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true, completion: nil)
        self.imageView.alpha = 0
        UIView.animate(withDuration: 2, delay: 0, options: []) {
            self.imageView.alpha = 1
        } completion: { finished in
            self.imageView.alpha = 1
        }

        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
        radiusProcessing()
        scaleProcessing()
        
    }


    @IBAction func changeFilter(_ sender: Any) {
        let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func setFilter(_ action: UIAlertAction? = nil){
        
        guard let actionTitle = action?.title else { return }
        
        title = actionTitle.replacingOccurrences(of: "CI", with: "")
        
        guard currentImage != nil else { return }
        
        currentFilter = CIFilter(name: actionTitle)
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        DispatchQueue.main.async {
            self.applyProcessing()
            self.radiusProcessing()
            self.scaleProcessing()
        }
    }
    
    @IBAction func save(_ sender: Any) {
        if let image = imageView.image{
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }else{
            self.showErrorMessage(title: "An Error!", message: "You don't select any image.\nPlease try again after choice a image by photo library.")
        }
    }
    
    
    @IBAction func intensityChange(_ sender: Any) {
        DispatchQueue.main.async {
            self.applyProcessing()
        }
    }
    
    
    @IBAction func radiusChanged(_ sender: Any) {
        DispatchQueue.main.async {
            self.radiusProcessing()
        }
    }
    
    @IBAction func scaleChanged(_ sender: Any) {
        DispatchQueue.main.async {
            self.scaleProcessing()
        }
       
    }
    
    func applyProcessing(){
        guard let currentImage = currentImage else{ return }
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey) }
        
        if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            self.imageView.image = processedImage
        }
    }
    
    func radiusProcessing(){
        guard currentImage != nil else{ return }
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(radiusSlider.value * 200, forKey: kCIInputRadiusKey) }
        if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            self.imageView.image = processedImage
        }
        
    }
    
    func scaleProcessing(){
        guard currentImage != nil else{ return }
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(scaleSlider.value * 10, forKey: kCIInputScaleKey) }
        if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            self.imageView.image = processedImage
        }
    }
    
    func showErrorMessage(title: String, message: String? = nil){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(ac,animated: true)
    }
    

    
}


