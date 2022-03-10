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
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        let leftButton1 = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(selectCode))
        let leftButton2 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCode))
        
        navigationItem.leftBarButtonItems = [leftButton1, leftButton2]
        
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
                        if let pageValue = self?.defaults.object(forKey: self!.pageTitle) as? String{
                            self?.script.text = pageValue
                        }
                    }
                }
            }
        }
        
        
        
    }
    
    @objc func addCode(){
        var alertTitle = ""
        guard let scriptText = script.text else { return }
        if self.pageTitle != ""{
            self.defaults.set(scriptText, forKey: self.pageTitle)
            alertTitle = "Save Completed"
        }else{
            alertTitle = "Save failed"
        }
        let ac = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(ac,animated: true)
    }
    
    @objc func selectCode(){
        let ac = UIAlertController(title: "Select Any Code", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Alert Template", style: .default, handler: selectCodeAction))
        ac.addAction(UIAlertAction(title: "Calculate Total", style: .default, handler: selectCodeAction))
        
        present(ac, animated: true)
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
