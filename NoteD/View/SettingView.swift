//
//  SettingView.swift
//  NoteD
//
//  Created by Gus Adi on 15/07/21.
//

import SwiftUI
import StoreKit

struct SettingView: View {
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    
    private var viewController: UIViewController? {
        self.viewControllerHolder.value
    }
    
    var body: some View {
        VStack(alignment: .center) {
            
            
            Button {
                DispatchQueue.main.async {
                    self.viewController?.present(style: .pageSheet, builder: {
                        LanguageSettingView()
                    })
                }
            } label: {
                HStack {
                    Image(systemName: "globe")
                    Text("setting_lang".localized(language))
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    Spacer()
                }
                .foregroundColor(Color("white"))
                .padding()
                .background(Color("royalBlue"))
                .cornerRadius(15)
                .shadow(color: Color("royalBlue").opacity(0.4), radius: 10, x: 0.0, y: 4)
            }
            .padding()
            
            Button {
                if let windowScene = UIApplication.shared.windows.first?.windowScene { SKStoreReviewController.requestReview(in: windowScene) }
            } label: {
                HStack {
                    Image(systemName: "star.fill")
                    Text("setting_rate".localized(language))
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                    Spacer()
                }
                .foregroundColor(Color("white"))
                .padding()
                .background(Color("royalBlue"))
                .cornerRadius(15)
                .shadow(color: Color("royalBlue").opacity(0.4), radius: 10, x: 0.0, y: 4)
            }
            .padding(.horizontal)
            
            HStack(spacing: 5) {
                Text("setting_version".localized(language))
                Text("\(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)")
            }
            .font(.system(size: 14, weight: .regular, design: .rounded))
            .foregroundColor(.gray)
            .padding()
            
            Spacer()
            
        }
        
        .navigationTitle("shared_titlesetting".localized(language))
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
