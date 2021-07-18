//
//  NoteEditTextView.swift
//  NoteD
//
//  Created by Gus Adi on 15/07/21.
//

import SwiftUI
import SwiftUIGenericDialog

struct NoteEditTextView: View {
    @State var date = Date()
    
    @State private var showDialog = false
    @State private var showDialogFail = false
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    
    private var viewController: UIViewController? {
        self.viewControllerHolder.value
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<Note>
    
    @State var note = Note()
    @State var text = "Title"
    @State var desc = ""
    @State private var textHeight : CGFloat = 45
    @State private var descTextHeight : CGFloat = 45
    
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
                            .foregroundColor(Color("textColor"))
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
                        .frame(height: descTextHeight)
                        .accentColor(Color("textColor"))
                    
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .toolbar(content: {
            Button(action: {
                
                updateItems(note: note, title: text, date: date, desc: desc)
                
            }, label: {
                Text("note_save".localized(language))
            })
        })
        .genericDialog(isShowing: $showDialog) {
            VStack {
                Text("notif_titlesucces".localized(language))
                    .fontWeight(.bold)
                Divider()
                Text("notif_bodysucces".localized(language))
                    .padding(.bottom, 10)

                Button(action: {
                    showDialog = false
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("notif_buttonclose".localized(language))
                        .autocapitalization(.allCharacters)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color("royalBlue"))
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .cornerRadius(40)
                        .frame(width: 140, height: 80, alignment: .center)

                }
            }.padding(22)
        }
        .genericDialog(isShowing: $showDialogFail) {
            VStack {
                Text("notif_titlefail".localized(language))
                    .fontWeight(.bold)
                Divider()
                Text("notif_bodyfail".localized(language))
                    .padding(.bottom, 10)
                
                Button(action: {
                    showDialogFail = false
                }) {
                    Text("notif_buttonclose".localized(language))
                        .autocapitalization(.allCharacters)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color("royalBlue"))
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .cornerRadius(40)
                        .frame(width: 140, height: 80, alignment: .center)
                        
                }
            }.padding(22)
        }
        
        
        
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func updateItems(note: Note, title: String, date: Date, desc: String) {
        let newTitle = title
        let newDate = date
        let newDesc = desc
        
        viewContext.performAndWait {
            note.title = newTitle
            note.date = newDate
            note.detail = newDesc
            do {
                try viewContext.save()
                self.showDialog = true
            } catch {
                self.showDialogFail = true
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

struct NoteEditTextView_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditTextView()
    }
}
