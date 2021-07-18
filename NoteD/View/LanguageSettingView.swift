//
//  LanguageSettingView.swift
//  NoteD
//
//  Created by Gus Adi on 16/07/21.
//

import SwiftUI

struct LanguageSettingView: View {
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    
    private var viewController: UIViewController? {
        self.viewControllerHolder.value
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            
            Button {
                LocalizationService.shared.language = .indonesian
                self.viewController?.dismiss(animated: true, completion: nil)
            } label: {
                HStack {
                    Text("Indonesia")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("textColor"))
                    Spacer()
                }
            }
            .padding(.top)
            .padding(.horizontal)
            .padding(.vertical, 5)
            
            Divider()
            
            Button {
                LocalizationService.shared.language = .english_us
                self.viewController?.dismiss(animated: true, completion: nil)
            } label: {
                HStack {
                    Text("English (US)")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("textColor"))
                    Spacer()
                }
            }
            .padding(.horizontal)
            Spacer()
            
        }
        
        .navigationTitle("shared_titlesetting".localized(language))
    }
}

struct LanguageSettingView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSettingView()
    }
}
