//
//  ContentView.swift
//  NoteD
//
//  Created by Gus Adi on 14/07/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.title, ascending: true)],
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
                                destination: NoteTextView(),
                                label: {
                                    NoteCellView()
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
                            .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding()
                            .foregroundColor(.white)
                    }
                    .background(Color("royalBlue"))
                    .clipShape(Circle())
                    .shadow(color: Color("royalBlue").opacity(0.5), radius: 6, x: 0.0, y: 4)
                    .padding()
                })
            }
            
            
            .navigationTitle("Note & Daily Journal")
        }
        .accentColor(Color("royalBlue"))
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Note(context: viewContext)
            newItem.title = "test"
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
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
