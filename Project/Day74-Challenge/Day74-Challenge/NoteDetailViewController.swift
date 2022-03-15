//
//  NoteDetailViewController.swift
//  Day74-Challenge
//
//  Created by Mehmet Ateş on 15.03.2022.
//

import UIKit

class NoteDetailViewController: UIViewController {
    @IBOutlet var NoteField: UITextView!
    
    var lastParent = UIViewController()
    
    var thisNote = Note(id: 0, title: "", detail: "")
    
    var noteId: Int?
    var noteTitle: String?
    var noteDetail: String?
    var notes: [Note]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shareNoteButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareNote))
        
        shareNoteButton.tintColor = UIColor.systemOrange
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbarItems = [spacer,shareNoteButton]
        
        if let noteTitle = noteTitle {
            self.thisNote.title = noteTitle
        }
        
        if let noteDetail = noteDetail {
            self.thisNote.detail = noteDetail
        }
        
        if let noteId = noteId {
            self.thisNote.id = noteId
        }else{
            self.thisNote.id = notes?.count ?? 0
        }
        
       
        self.NoteField.text = self.thisNote.detail
    }

    @objc func shareNote(){
        let ac = UIActivityViewController(activityItems: [thisNote.detail], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedNote = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedNote, forKey: "notes")
        } else {
            print("Failed to save notes.")
        }
    }
    
    func viewSaveNote(){
        let isNoteNew = self.notes?.first(where: { myNote in
            myNote.id == thisNote.id
        })
        
        if let myNote = isNoteNew{
            if let index = self.notes?.firstIndex(of: myNote){
                self.notes?.remove(at: index)
            }
        }
        self.thisNote.detail = self.NoteField.text
        
        if self.thisNote.detail != ""{
            if self.NoteField.text.split(separator: "\n").count != 0 {
                self.thisNote.title = self.NoteField.text.split(separator: "\n")[0].description
            }
            self.notes?.append(self.thisNote)
            save()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewSaveNote()
    }
}
