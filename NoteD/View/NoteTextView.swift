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
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                VStack {
                    
                    
                    
                    Button(action: {
                        DispatchQueue.main.async {
                            self.viewController?.present(style: .formSheet, builder: {
                                CalendarView(date: $date)
                            })
                        }
                    }, label: {
                        Text("\(itemFormatter.string(from: date))")
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                            .foregroundColor(.black)
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color("textColor"), lineWidth: 1)
                            )
                    })
                }
                .padding()
            }
        }
        .toolbar(content: {
            Button(action: {}, label: {
                Text("Save")
            })
        })
        
        .navigationBarTitleDisplayMode(.inline)
        
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
        NoteTextView()
    }
}
