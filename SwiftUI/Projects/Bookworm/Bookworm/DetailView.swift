//
//  DetailView.swift
//  Bookworm
//
//  Created by Mehmet Ateş on 19.05.2022.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    private let genreImages = [
        "Fantasy" : URL(string: "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3384")!,
        "Horror" : URL(string: "https://images.unsplash.com/photo-1516410529446-2c777cb7366d?ixlib=rb-1.2.1&raw_url=true&q=80&fm=jpg&crop=entropy&cs=tinysrgb&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774")!,
        "Kids" : URL(string: "https://images.unsplash.com/photo-1503919545889-aef636e10ad4?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774")!,
        "Mystery" : URL(string: "https://images.unsplash.com/photo-1598615821969-e4b1c7fcf24d?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064")!,
        "Poetry" : URL(string: "https://images.unsplash.com/photo-1487147264018-f937fba0c817?ixlib=rb-1.2.1&raw_url=true&q=80&fm=jpg&crop=entropy&cs=tinysrgb&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774")!,
        "Romance" : URL(string: "https://images.unsplash.com/photo-1521033719794-41049d18b8d4?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774")!,
        "Thriller" : URL(string: "https://images.unsplash.com/photo-1629203432180-71e9b18d855c?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=726")!,
    ]
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    let book: Book
    
    var body: some View {
        ScrollView {
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
            if let bookReviewDate = book.reviewDate{
                Text(bookReviewDate, format: Date.FormatStyle().year().month().day())
            }
            
            Text(book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: genreImages[book.genre ?? "Fantasy"], scale: 1, transaction: Transaction.init(animation: .easeInOut)) { phase in
                    if let loadedImage = phase.image{
                        loadedImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.size.width * 0.9, height: UIScreen.main.bounds.size.width * 1.2, alignment: .center)
                            .cornerRadius(10)
                            .padding()
                            
                    }else if phase.error != nil{
                        Image(systemName: "wifi.exclamationmark")
                            .resizable()
                            .scaledToFit()
                    }else{
                        ProgressView()
                            .frame(width: UIScreen.main.bounds.size.width * 0.9, height: UIScreen.main.bounds.size.width * 1.2, alignment: .center)
                    }
                }
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
        }.alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }.toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func deleteBook() {
        moc.delete(book)
        
        // uncomment this line if you want to make the deletion permanent
        // try? moc.save()
        dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
