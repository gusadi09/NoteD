//
//  ContentView.swift
//  NoteD
//
//  Created by Gus Adi on 14/07/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var isActive = false
    @State var isActiveSec = false
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<Note>
    @State var selection: UUID? = nil
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                if items.isEmpty {
                    ScrollView(.vertical, showsIndicators: false) {
                        HStack {
                            Spacer()
                            
                            VStack(alignment: .center) {
                                Image("emptyImage")
                                    .resizable()
                                    .frame(width: 200, height: 160, alignment: .center)
                                Text("home_emptytext".localized(language))
                                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                                    .padding(.horizontal, 30)
                                    .multilineTextAlignment(.center)
                                Spacer()
                            }
                            .padding(.top, 100)
                            
                            Spacer()
                        }
                    }
                } else {
                    List {
                        ForEach(items, id: \.id) { note in
                            NavigationLink(destination: NoteEditTextView(date: note.date ?? Date(), note: note, text: note.title ?? "Title", desc: note.detail ?? ""), tag: note.id ?? UUID(), selection: self.$selection,
                                           label: {
                                            NoteCellView(items: note)
                                           })
                        }
                        .onDelete(perform: { indexSet in
                            deleteItems(offsets: indexSet)
                        })
                        .padding(.vertical, 8)
                        
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                }
                
                Button(action: {
                    addItem()
                }, label: {
                    HStack {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .padding(3)
                            .frame(width: 40, height: 40, alignment: .center)
                            .padding()
                            .foregroundColor(.white)
                    }
                    .background(Color("royalBlue"))
                    .clipShape(Circle())
                    .shadow(color: Color("royalBlue").opacity(0.5), radius: 6, x: 0.0, y: 4)
                    .padding()
                })
                
            }
            
            .toolbar(content: {
                HStack {
                    EditButton()
                    NavigationLink(
                        destination: SettingView(),
                        label: {
                            Image(systemName: "gear")
                        })
                        .isDetailLink(true)
                }
            })
            .navigationTitle("shared_appstitle".localized(language))
            
        }
        .accentColor(Color("royalBlue"))
    }
    
    func addItem() {
        withAnimation {
            let newItem = Note(context: viewContext)
            newItem.id = UUID()
            newItem.title = "Title"
            newItem.date = Date()
            newItem.detail = ""
            
            self.selection = newItem.id
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
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
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
