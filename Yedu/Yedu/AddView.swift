//
//  AddView.swift
//  Yedu
//
//  Created by Trần T. Dũng  on 24/06/2022.
//

import SwiftUI

struct AddView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var company: String = ""
    
    var body: some View {
        VStack {
            HStack {
                
            }
            .padding(20)
            HStack {
                Image("Yedu")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 175, height: 175) // 📐 Fixed avatar size
                
            }
            .overlay(
                Circle()
                //                           🔘 The thin gray stroke for the avatar in RGB code
                //                                                    |
                //                       ---------------------------------------------------------
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.5), lineWidth: 2)
            )
            .padding()
            VStack {
                HStack {
                    Text("Name: ")
                    TextField("Johnny Appleseed", text: $lastName)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                HStack {
                    Text("Email: ")
                    //     🤡 Distracting the email recognition
                    //                      |
                    //        -----------------------------
                    TextField("johnappleseed@apple\(".")com", text: $email)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                HStack {
                    Text("Company: ")
                    TextField("Your organization", text: $company)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
            }
            .padding()
            
            Spacer()
            
            Button("ADD USER") {    // 😞 Unfinished function due to died API
            }
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.blue)
            .padding()
        }
    }
}

#if DEBUG
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
#endif
