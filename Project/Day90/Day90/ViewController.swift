//
//  ViewController.swift
//  Day90
//
//  Created by Mehmet Ateş on 31.03.2022.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var upTextField: UITextField!
    @IBOutlet var bottomTextField: UITextField!
    var firstImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meme Creator"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(selectPhoto))
        
        upTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        bottomTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    @objc func textChanged(_ textField: UITextField){
       drawImage()
    }
    
    @objc func selectPhoto(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        imageView.image = image
        
        dismiss(animated: true)
    }

    @IBAction func upTextToggle(_ sender: UISwitch) {
        
        upTextField.isEnabled = sender.isOn
        
        if !sender.isOn{
            upTextField.text = ""
            drawImage()
        }
       
    }
    
    @IBAction func bottomTextToggle(_ sender: UISwitch) {
       
        bottomTextField.isEnabled = sender.isOn
        
        if !sender.isOn{
            bottomTextField.text = ""
            drawImage()
        }
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        guard let willSendImage = self.imageView.image else { return }
        
        let ac = UIActivityViewController(activityItems: [willSendImage], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    func drawImage(){
        guard let currentImage = imageView.image else { return }
        if firstImage == nil{
            firstImage = currentImage
        }
        
        imageView.image = firstImage
        
        let renderer = UIGraphicsImageRenderer(size: currentImage.size)
        
        let img = renderer.image { ctx in
            imageView.image?.draw(at: CGPoint(x: 0, y: 0))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 100, weight: .bold),
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraphStyle
            ]
            
            let upText = self.upTextField.text ?? ""
            let bottomText = self.bottomTextField.text ?? ""
            let attributedUpText = NSAttributedString(string: upText, attributes: attrs)
            let attributedBottomText = NSAttributedString(string: bottomText, attributes: attrs)
            
            attributedUpText.draw(with: CGRect(x: 0, y: 0, width: currentImage.size.width, height: 130), options: .usesLineFragmentOrigin, context: nil)
            attributedBottomText.draw(with: CGRect(x: 0, y: currentImage.size.height - 150, width: currentImage.size.width, height: 130), options: .usesLineFragmentOrigin, context: nil)

        }
        imageView.image = img
    }
    
}

