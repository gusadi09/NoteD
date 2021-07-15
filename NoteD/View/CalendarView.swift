//
//  CalendarView.swift
//  NoteD
//
//  Created by Gus Adi on 15/07/21.
//

import SwiftUI

struct CalendarView: View {
    @Binding var date: Date
    var dateNow = Date()
    
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    
    private var viewController: UIViewController? {
        self.viewControllerHolder.value
    }
    
    var body: some View {
        VStack {
            DatePicker(selection: $date, displayedComponents: .date) {
                
            }
            .onChange(of: date, perform: { value in
                viewController?.dismiss(animated: true, completion: nil)
            })
            .datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
            .padding()
            
            
            Spacer()
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(date: .constant(Date()))
    }
}
