//
//  HomeViewController.swift
//  Day99
//
//  Created by Mehmet Ateş on 9.04.2022.
//

import UIKit
import LocalAuthentication

class HomeViewController: UIViewController {
    @IBOutlet var playButton: UIButton!
    @IBOutlet var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.isEnabled = false
        editButton.isEnabled = false

        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Identfy yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, accessError in
                DispatchQueue.main.async {
                    if success {
                        self?.playButton.isEnabled = true
                        self?.editButton.isEnabled = true
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
        let appPassword = "123456"
        if password == appPassword{
            self.playButton.isEnabled = true
            self.editButton.isEnabled = true
        }else{
            let errorAc = UIAlertController(title: "Wrong password", message: nil, preferredStyle: .alert)
            errorAc.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: unlockWithPassword))
            errorAc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(errorAc, animated: true)
        }
    }

    
    @IBAction func playButtonTapped(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PlayScreen") else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "EditScreen") else { return }
        navigationController?.pushViewController(vc, animated: true)
    }

}
