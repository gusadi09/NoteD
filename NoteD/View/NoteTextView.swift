//
//  NoteTextView.swift
//  NoteD
//
//  Created by Gus Adi on 15/07/21.
//

import SwiftUI

struct NoteTextView: View {
    @State var date = Date()
    
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    
    private var viewController: UIViewController? {
        self.viewControllerHolder.value
    }
    
    @State var viewContext = PersistenceController.shared.container.viewContext
    
    @State var text = "Title"
    @State var desc = ""
    @State private var textHeight : CGFloat = 45
    @State private var descTextHeight : CGFloat = 45
    @Binding var isActive: Bool
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                
                ZStack {
                    TitleFieldView(text: $text, heightToTransmit: $textHeight)
                        .frame(height: textHeight)
                        .accentColor(Color("textColor"))
                }
                .padding(.top, 20)
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    
                    
                    Button(action: {
                        DispatchQueue.main.async {
                            self.viewController?.present(style: .formSheet, builder: {
                                CalendarView(date: $date)
                            })
                        }
                    }, label: {
                        Text("\(itemFormatter.string(from: date))")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(.black)
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color("textColor"), lineWidth: 1)
                            )
                    })
                    .padding(.vertical, 2)
                    
                    
                }
                .padding(.horizontal)
                
                ZStack {
                    
                    TextFieldView(text: $desc, heightToTransmit: $descTextHeight)
                        .frame(height: textHeight)
                        .accentColor(Color("textColor"))
                                        
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .toolbar(content: {
            Button(action: {
                addItem()
                self.isActive = false
            }, label: {
                Text("Save")
            })
        })
        
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func addItem() {
        withAnimation {
            let newItem = Note(context: viewContext)
            newItem.title = text
            newItem.date = date
            newItem.detail = desc

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = "dd / MM / yyyy"
    return formatter
}()

struct NoteTextView_Previews: PreviewProvider {
    static var previews: some View {
        NoteTextView(isActive: .constant(true))
    }
}
