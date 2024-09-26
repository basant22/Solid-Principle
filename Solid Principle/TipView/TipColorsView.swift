//
//  TipColorsView.swift
//  Solid Principle
//
//  Created by Kumar Basant on 18/07/24.
//

import SwiftUI
import TipKit
struct TipColorsView: View {
    @State private var colors = MockData.colors
    @EnvironmentObject private var router:Router
    let addColorTip = AddColorTip()
    let setColorTip = SetFavoriteTip()
    var body: some View {
        ScrollView{
            TipView(setColorTip)
                .tipBackground(.teal.opacity(0.40))
            ForEach(colors,id: \.self){
                RoundedRectangle(cornerRadius:12)
                    .fill($0.gradient)
                    .frame(height:100)
                    .contextMenu(ContextMenu(menuItems: {
                        Button("favorite",systemImage: "star"){
                            Task{
                                await SetFavoriteTip.setFavoriteEvent.donate()
                            }
                        }
                    }))
            }
        }
        .onAppear{
            Task{
                await SetFavoriteTip.colorViewVisitedEvent.donate()
            }
        }
        .ignoresSafeArea()
        .navigationTitle("TipView")
        /*.toolbar{
            Button {
                colors.insert(.random, at: 0)
            } label: {
                Image(systemName: "plus")
            }
            .popoverTip(addColorTip)
        }*/
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading){
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 12,height: 20)
                    .foregroundColor(.green)
                    .onTapGesture {
                        withAnimation {
                            router.path.removeLast()
                        }
                    }
            }
            ToolbarItem(placement: .topBarTrailing){
                Button {
                    colors.insert(.random, at: 0)
                    addColorTip.invalidate(reason: .actionPerformed)
                } label: {
                    Image(systemName: "plus")
                }
                .popoverTip(addColorTip)
            }
        })
        .navigationBarBackButtonHidden(true)
        .padding()
    }
}

#Preview {
    TipColorsView()
        .task {
            try? Tips.resetDatastore()
            try? Tips.configure(
                [.displayFrequency(.immediate),
                 .datastoreLocation(.applicationDefault)])
        }
}
extension Color{
    static var random:Color{
        return Color(Resolved(red: Float(Double.random(in: 0...1)), green:  Float(Double.random(in: 0...1)), blue:  Float(Double.random(in: 0...1))))
    }
}
struct MockData{
   static let colors = [Color.random,Color.random,Color.random,Color.random,Color.random,Color.random,]
}
