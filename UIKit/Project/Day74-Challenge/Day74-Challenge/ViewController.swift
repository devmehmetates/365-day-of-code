//
//  ViewController.swift
//  Day74-Challenge
//
//  Created by Mehmet Ateş on 15.03.2022.
//

import UIKit

class ViewController: UITableViewController {
    var notes = [Note]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Welcome Notes!"
        loadNotes()
        
        navigationController?.isToolbarHidden = false
        
        let addNote = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .done, target: self, action: #selector(addNote))
        
        addNote.tintColor = UIColor.systemOrange
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbarItems = [spacer,addNote]
        
       
        
        self.notes.sort { note1, note2 in
            note1.id < note2.id
        }
        
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)

    }
    
    @objc func refresh(sender:AnyObject)
    {
        loadNotes()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

    
    @objc func addNote(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "NoteDetail") as? NoteDetailViewController else { return }
        
        vc.notes = notes
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadNotes(){
        if let savedNotes = defaults.object(forKey: "notes") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                notes = try jsonDecoder.decode([Note].self, from: savedNotes)
                self.notes.sort { note1, note2 in
                    note1.id < note2.id
                }
            } catch {
                print("Notes can not loaded")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.notes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        
        var noteDetail = ""
        if notes[indexPath.row].detail.split(separator: "\n").count >= 2 {
            noteDetail = notes[indexPath.row].detail.split(separator: "\n")[1].description
        }
        
        cell.detailTextLabel?.text = noteDetail
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "NoteDetail") as? NoteDetailViewController else { return }
        
        vc.noteTitle = notes[indexPath.row].title
        vc.noteDetail = notes[indexPath.row].detail
        vc.noteId = notes[indexPath.row].id
        vc.notes = notes
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.notes.remove(at: indexPath.row)
            DispatchQueue.global(qos: .background).async {
                self.save()
                self.loadNotes()
            }
            self.tableView.reloadData()
        }
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
    


    
    

}

