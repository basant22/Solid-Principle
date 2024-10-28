//
//  CustomTabBarView.swift
//  Solid Principle
//
//  Created by Kumar Basant on 24/10/24.
//

import SwiftUI

struct CustomTabBarView: View {
    let tabs:[TabBarItem]
    @Binding var tabSelection:TabBarItem
    @Namespace private var nameSpace
    @State var localSelection:TabBarItem
    var body: some View {
        tabBarVersion2
//            .onChange(of: localSelection) { oldValue, newValue in
//                withAnimation(.easeInOut){
//                localSelection = newValue
//              }
//            }
    }
}

#Preview {
    VStack{
        Spacer()
        CustomTabBarView(tabs: [.home,.favirite,.profile],tabSelection: .constant(.home), localSelection: .home)
    }
}
/*
 TabBarItem(tabIcon: "house", title: "Home", color: Color.red),
 TabBarItem(tabIcon: "heart", title: "Favorites", color: Color.blue),
 TabBarItem(tabIcon: "person", title: "Person", color: Color.green)
 */
extension CustomTabBarView{
    private func tabView(tab:TabBarItem)-> some View{
        VStack{
            Image(systemName: tab.tabIcon)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size:10,weight: .semibold,design: .rounded))
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(tabSelection == tab ? tab.color : Color.gray)
        .padding(.vertical,8)
        .background(tabSelection == tab ? tab.color.opacity(0.20):Color.clear)
        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 5,bottomLeading: 5,bottomTrailing: 5,topTrailing: 5)))
    }
    private var tabBarVersion1 : some View{
        HStack{
            ForEach(tabs,id: \.self) { tab in
              tabView(tab: tab)
                    .onTapGesture {
                        switchTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges:.bottom))
    }
    func switchTab(tab:TabBarItem){
        withAnimation(.easeInOut){
            tabSelection = tab
        }
    }
}
extension CustomTabBarView{
    private func tabView2(tab:TabBarItem)-> some View{
        VStack{
            Image(systemName: tab.tabIcon)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size:10,weight: .semibold,design: .rounded))
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(tabSelection == tab ? tab.color : Color.gray)
        .padding(.vertical,8)
        .background(
                ZStack{
                    if tabSelection == tab{
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(tab.color.opacity(0.20))
                            .matchedGeometryEffect(id: "background_tab", in: nameSpace)
                    }
                }
        )
       // .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 5,bottomLeading: 5,bottomTrailing: 5,topTrailing: 5)))
    }
    private var tabBarVersion2 : some View{
        HStack{
            ForEach(tabs,id: \.self) { tab in
              tabView2(tab: tab)
                    .onTapGesture {
                        switchTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges:.bottom))
        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 10,bottomLeading: 10,bottomTrailing: 10,topTrailing: 10)))
        .shadow(color:Color.black.opacity(0.20), radius: 10.0,x: 0.0,y: 5.0)
        .padding(.horizontal)
    }
}
//struct TabBarItem:Hashable{
//    var tabIcon:String
//    var title:String
//    var color:Color
//}
