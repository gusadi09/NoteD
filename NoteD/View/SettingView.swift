//
//  SettingView.swift
//  NoteD
//
//  Created by Gus Adi on 15/07/21.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @Binding var isActive: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button {
                // Step #3
                LocalizationService.shared.language = .indonesian
                isActive = false
            } label: {
                Text("Indonesia")
            }
            Button {
                LocalizationService.shared.language = .english_us
                isActive = false
            } label: {
                Text("English (US)")
            }
            
            Spacer()
        }
        
        .navigationTitle("shared_titlesetting".localized(language))
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isActive: .constant(true))
    }
}
