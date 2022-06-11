//
//  ObjectCollectionView.swift
//  ObjectPhotoList
//
//  Created by Mehmet Ateş on 10.06.2022.
//

import SwiftUI

struct ObjectCollectionView: View {
    @StateObject private var viewModel = ObjectCollectionViewModel()
    
    let gridItems = [GridItem(.adaptive(minimum: 100, maximum: 100), spacing: UIScreen.main.bounds.size.width * 0.05,  alignment: .center)]
    let imageSize = UIScreen.main.bounds.size.width * 0.3
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: gridItems) {
                    ForEach(viewModel.objects) { object in
                        NavigationLink{
                            ImageDetailView(object: object)
                        } label: {
                            VStack{
                                Image(uiImage: UIImage(data: object.imageData)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: imageSize, height: imageSize, alignment: .center)
                                    .clipped()
                                    .cornerRadius(10)
                                Text(object.name)
                                    .font(.headline)
                            }
                        }
                    }
                }
            }.navigationTitle("Add an object")
                .toolbar {
                    Button {
                        viewModel.sheetImagePicker.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }

        }.sheet(isPresented: $viewModel.sheetImagePicker, onDismiss: {
            viewModel.alertToggle.toggle()
        }) {
            ImagePickerView(image: $viewModel.pickedImage)
        }.textFieldAlert(
            isPresented: $viewModel.alertToggle,
            title: "Add an object",
            text: "",
            placeholder: "Object name",
            action: { newText in
                viewModel.pickedName = newText ?? ""
                viewModel.saveModel(self.viewModel.locationFetcher.lastKnownLocation)
            }
        )
    }
}

struct ObjectCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ObjectCollectionView()
    }
}


extension View {
    public func textFieldAlert(
        isPresented: Binding<Bool>,
        title: String,
        text: String = "",
        placeholder: String = "",
        action: @escaping (String?) -> Void
    ) -> some View {
        self.modifier(TextFieldAlertModifier(isPresented: isPresented, title: title, text: text, placeholder: placeholder, action: action))
    }
    
}

public struct TextFieldAlertModifier: ViewModifier {

    @State private var alertController: UIAlertController?

    @Binding var isPresented: Bool

    let title: String
    let text: String
    let placeholder: String
    let action: (String?) -> Void

    public func body(content: Content) -> some View {
        content.onChange(of: isPresented) { isPresented in
            if isPresented, alertController == nil {
                let alertController = makeAlertController()
                self.alertController = alertController
                guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                    return
                }
                scene.windows.first?.rootViewController?.present(alertController, animated: true)
            } else if !isPresented, let alertController = alertController {
                alertController.dismiss(animated: true)
                self.alertController = nil
            }
        }
    }

    private func makeAlertController() -> UIAlertController {
        let controller = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        controller.addTextField {
            $0.placeholder = self.placeholder
            $0.text = self.text
        }
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.action(nil)
            shutdown()
        })
        controller.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.action(controller.textFields?.first?.text)
            shutdown()
        })
        return controller
    }

    private func shutdown() {
        isPresented = false
        alertController = nil
    }

}
