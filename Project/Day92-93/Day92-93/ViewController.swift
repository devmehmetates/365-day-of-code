//
//  ViewController.swift
//  Day92-93
//
//  Created by Mehmet Ateş on 2.04.2022.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    @IBOutlet var secret: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        KeychainWrapper.standard.set("123456", forKey: "Password")
        
        title = "Nothing see here"
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    }

    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }

    
    @IBAction func authenticateTabbed(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Identfy yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, accessError in
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
                    }else{
                        let ac = UIAlertController(title: "Login unsuccessful!", message: "Do you wanna use password?", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "Use password", style: .default, handler: self?.unlockWithPassword))
                        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                        self?.present(ac, animated: true)
                    }
                }
                
            }
        }else{
            let ac = UIAlertController(title: "Your device not have a enrolled face id or not support to face id", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "okay", style: .cancel))
            self.present(ac, animated: true)
        }
       
    }
    
    func unlockWithPassword(_ action: UIAlertAction? = nil){
        let passwordAc = UIAlertController(title: "Enter Your password", message: nil, preferredStyle: .alert)
        passwordAc.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){ [weak self, weak passwordAc] _ in
            guard let field = passwordAc?.textFields?[0].text else { return }
            self?.checkPassword(password: field)
        }
        
        passwordAc.addAction(submitAction)
        present(passwordAc, animated: true)
    }
    
    func checkPassword(password: String){
        let appPassword = KeychainWrapper.standard.string(forKey: "Password") ?? ""
        if password == appPassword{
            unlockSecretMessage()
        }else{
            let errorAc = UIAlertController(title: "Wrong password", message: nil, preferredStyle: .alert)
            errorAc.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: unlockWithPassword))
            errorAc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(errorAc, animated: true)
        }
    }
    
    func unlockSecretMessage(){
        secret.isHidden = false
        title = "Secret stuff!"
        
        secret.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveSecretMessage))
        
    }
    
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return }
        
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder()
        secret.isHidden = true
        title = "Nothing to see here"
        navigationItem.rightBarButtonItem = nil
    }
    
}

