//
//  UserView.swift
//  Yedu
//
//  Created by Trần T. Dũng  on 24/06/2022.
//

import SwiftUI

struct CardView: View {
    
    let user: User
    
    var body: some View {
        HStack {
            NavigationLink(destination: DetailView(user: user)) {
                HStack {
                    Image("Yedu")   // 😵‍💫 The rectangle frame photo is definitely looks better than the rounded bezel
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .padding()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(user.name)".uppercased())
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Text("\(user.email)")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        Text("Company: \(user.company.name)".uppercased())
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
            }
        }
        .cornerRadius(20)   // 🍎 As an Apple Developer you needs to have custom rounded corner everywhere 😉
    }
}

#if DEBUG
struct UserView_Previews: PreviewProvider {
    static var previews: some View {
            CardView(user: .init(id: 0, // 😬 Give it an initializer to prevent fetch errors
                                 email: "vernytran@gmail.com",
                                 name: "Dũng Trần",
                                 company: .init(name: "Young Education")))
        }
}
#endif
