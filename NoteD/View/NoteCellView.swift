//
//  NoteCellView.swift
//  NoteD
//
//  Created by Gus Adi on 14/07/21.
//

import SwiftUI

struct NoteCellView: View {
    //var items: Note
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Title")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                
                Text("22/08/2021")
                    .font(.system(size: 12))
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color("textColor"), lineWidth: 1)
                    )
                
                
                Text("Description")
                    .font(.system(size: 18))
                    .lineLimit(1)
                
            }
            .foregroundColor(Color("textColor"))
            
            Spacer()
        }
    }
}

struct NoteCellView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCellView()
    }
}
