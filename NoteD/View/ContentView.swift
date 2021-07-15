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
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.date, ascending: true)],
    animation: .default)
    private var items: FetchedResults<Note>
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                if items.isEmpty {
                    HStack {
                        Spacer()
                        
                        VStack {
                            Image("emptyImage")
                                .resizable()
                                .frame(width: 200, height: 160, alignment: .center)
                            Text("You haven't created any notes yet")
                                .font(.system(size: 22, weight: .semibold, design: .rounded))
                            Spacer()
                        }
                        .padding(.top, 180)
                        
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(items) { note in
                            NavigationLink(
                                destination: NoteTextView(date: note.date ?? Date(), viewContext: self.viewContext, text: note.title ?? "Title", desc: note.detail ?? "", isActive: $isActive),
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
                
                NavigationLink(
                    destination: NoteTextView( isActive: self.$isActive),
                    isActive: $isActive,
                    label: {
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
                    .isDetailLink(true)
                
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
            .navigationTitle("\(LocalizationConst.Shared.appstitle.localized())")
        }
        .accentColor(Color("royalBlue"))
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
