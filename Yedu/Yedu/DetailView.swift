//
//  DetailView.swift
//  Yedu
//
//  Created by Trần T. Dũng  on 24/06/2022.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        VStack {
            HStack {
                
            }.padding(20)
            HStack {
                Image("Yedu")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 175, height: 175)
                
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
                Text("\(user.name)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text("\(user.email)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                VStack {
                    Text("Company: \(user.company.name)".uppercased())
                        .font(.headline)
                        .foregroundColor(.secondary)
                }.padding()
                
                Spacer()
                
                HStack {
                    Button(action: {}) {
                        Text("CHANGE NAME") // 😞 Unfinished function due to died API
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(height: 80)
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue))
                    .padding()
                }
                .padding()
            }
            .padding()
            
            Spacer()
        }
    }
}

#if DEBUG
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(user: .init(id: 0,   // 😬 Give it an initializer to prevent fetch errors
                               email: "vernytran@gmail.com",
                               name: "Dũng Trần",
                               company: .init(name: "Young Education")))
    }
}
#endif
