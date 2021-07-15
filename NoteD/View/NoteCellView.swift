//
//  NoteCellView.swift
//  NoteD
//
//  Created by Gus Adi on 14/07/21.
//

import SwiftUI

struct NoteCellView: View {
    @ObservedObject var items: Note
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("\(items.title ?? "Title")")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .lineLimit(1)
                
                Text("\(itemFormatter.string(from: items.date ?? Date()))")
                    .font(.system(size: 12))
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color("textColor"), lineWidth: 1)
                    )
                
                
                Text("\(items.detail ?? "")")
                    .font(.system(size: 18))
                    .lineLimit(1)
                
            }
            .foregroundColor(Color("textColor"))
            
            Spacer()
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = "dd / MM / yyyy"
    return formatter
}()

struct NoteCellView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCellView(items: Note())
    }
}
