//
//  SideMenuHeaderView.swift
//  Solid Principle
//
//  Created by Kumar Basant on 22/07/24.
//

import SwiftUI

struct SideMenuHeaderView: View {
    var body: some View {
        HStack{
            Image(systemName: "person.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 12.0))
                .padding(.vertical)
            VStack(alignment: .leading, spacing: 6){
                Text("Kumar Basant")
                    .font(.subheadline)
                Text("IOS Developer")
                    .font(.footnote)
                    .tint(.gray)
            }
        }
    }
}

#Preview {
    SideMenuHeaderView()
}
