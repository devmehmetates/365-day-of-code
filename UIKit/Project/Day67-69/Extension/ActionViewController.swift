//
//  ActionViewController.swift
//  Extension
//
//  Created by Mehmet Ateş on 8.03.2022.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {
    @IBOutlet var script: UITextView!
    
    var pageTitle = ""
    var pageURL = ""
    let defaults = UserDefaults.standard
    var userScripts = Dictionary<String, String>()
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        let leftButton1 = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(selectCode))
        let leftButton2 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCode))
        let leftButton3 = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showSavedScripts))
        
        navigationItem.leftBarButtonItems = [leftButton1, leftButton2, leftButton3]
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                        if let pageValue = self?.defaults.object(forKey: self!.pageTitle) as? Dictionary<String, String>{
                            self?.userScripts = pageValue
                            
                            if self?.userScripts.count != 0{
                                let ac = UIAlertController(title: "You have \(self!.userScripts.count) script for this page!", message: "Please select any script for start.", preferredStyle: .actionSheet)
                                ac.addAction(UIAlertAction(title: "No!", style: .cancel, handler: nil))
                                self?.userScripts.forEach {
                                    ac.addAction(UIAlertAction(title: $0.key, style: .default, handler: self?.selectUserCode))
                                }
                                self?.present(ac, animated: true)
                            }
                        }
                    }
                }
            }
        }
        
        
        
    }
    
    @objc func showSavedScripts(){
        let ac = UIAlertController(title: "You have \(self.userScripts.count) script for this page!", message: "Select one.", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "No!", style: .cancel, handler: nil))
        self.userScripts.forEach {
            ac.addAction(UIAlertAction(title: $0.key, style: .default, handler: self.selectUserCode))
        }
        present(ac, animated: true)
    }
    
    @objc func addCode(){
        let ac = UIAlertController(title: "Add Your Code", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.addAction(UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            var alertTitle = ""
            guard let scriptText = self?.script.text else { return }
            if self?.pageTitle != ""{
                self?.userScripts[newName] = scriptText
                self?.defaults.set(self?.userScripts, forKey: self!.pageTitle)
                alertTitle = "Save Completed"
            }else{
                alertTitle = "Save failed"
            }
            let sac = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
            sac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self?.present(sac,animated: true)
        })
        
        present(ac, animated: true)
    }
    
    @objc func selectCode(){
        let ac = UIAlertController(title: "Select Any Code", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Alert Template", style: .default, handler: selectCodeAction))
        ac.addAction(UIAlertAction(title: "Calculate Total", style: .default, handler: selectCodeAction))
        
        present(ac, animated: true)
    }
    
    func selectUserCode(action: UIAlertAction? = nil){
        guard let title = action?.title else { return }
        if let script = self.userScripts[title]{
            self.script.text = script
        }
    }
    
    func selectCodeAction(action: UIAlertAction? = nil){
        guard let title = action?.title else{ return }
        if title == "Alert Template"{
            self.script.text = "alert();"
        }else{
            self.script.text = """
            // write any process in alert code
            // example alert(3 + 7); -> 10
            alert();
            """
        }
        
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }

    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        
        extensionContext?.completeRequest(returningItems: [item])
    }

}
