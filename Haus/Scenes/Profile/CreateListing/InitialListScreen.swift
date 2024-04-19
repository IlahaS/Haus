//
//  InitialListScreen.swift
//  Haus
//
//  Created by Ilahe Samedova on 15.04.24.
//

import Foundation
import UIKit
import SwiftUI

struct InitialListScreen: View {
    var body: some View {
        
        VStack(spacing: 20) {
            
            Text("Xidmətimizi sınamağınız üçün sizə ay ərzində 2 elanı pulsuz yerləşdirmək imkanı təqdim edirik. Ay ərzində hər növbəti elan üçün ödəniş 5 AZN təşkil edir.")
                .foregroundColor(.black)
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
            
            Text("Eyni elanın təkrar paylaşılması qadağandır.")
                .foregroundColor(.black)
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
            
            Text("Elanın məzmununu başqa bir elanla əvəz etmək qadağandır.")
                .foregroundColor(.black)
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Text("Əmlakı")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 10)
            
            HStack(spacing: 20) {
                Button(action: {
                }) {
                    Text("Satıram")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                
                Button(action: {
                }) {
                    Text("Kirayə verirəm")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                }
                
                Button(action: {
                }) {
                    Text("Gündəlik Kirayə verirəm")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Yeni elan yarat.")
    }
}


class SwiftUIInitialListViewController: UIHostingController<InitialListScreen> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: InitialListScreen())
    }
}
