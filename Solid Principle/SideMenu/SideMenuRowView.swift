//
//  SideMenuRowView.swift
//  Solid Principle
//
//  Created by Kumar Basant on 22/07/24.
//

import SwiftUI

struct SideMenuRowView: View {
    let option:SideMenuOptionModel
    @Binding var selectedOption:SideMenuOptionModel?
    private var isSelected:Bool{
       return selectedOption == option
    }
    var body: some View {
        HStack{
            Image(systemName: option.systemImageName)
                .imageScale(.small)
            Text(option.title)
                .font(.subheadline)
            Spacer()
        }
        .padding(.leading)
        .foregroundStyle(isSelected ? .blue : .primary)
        .frame(width:216,height: 45)
        .background(isSelected ? .blue.opacity(0.25):.clear)
        .clipShape(RoundedRectangle(cornerRadius: 12.0))
    }
}

#Preview {
    SideMenuRowView(option: .dashboard, selectedOption: .constant(.dashboard))
}
