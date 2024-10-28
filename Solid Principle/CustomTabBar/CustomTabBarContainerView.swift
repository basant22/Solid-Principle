//
//  CustomTabBarContainerView.swift
//  Solid Principle
//
//  Created by Kumar Basant on 24/10/24.
//

import SwiftUI
/*struct TabView1<SelectionValue,Content>:View where SelectionValue:Hashable,Content:View{
    
}

struct TabView1<SelectionValue:Hashable,Content:View>:View{
    
}*/
struct CustomTabBarContainerView<Content:View>: View {
    @Binding var selection:TabBarItem
    let content:Content
    @State private var tabs:[TabBarItem] = []
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content){
        self._selection = selection
        self.content = content()
    }
    var body: some View {
            ZStack(alignment: .bottom){
                content
                    .ignoresSafeArea()
                CustomTabBarView(tabs: tabs, tabSelection: $selection, localSelection: selection)
            }
//        VStack(spacing:0){
//            ZStack{
//                content
//            }
//            CustomTabBarView(tabs: tabs, tabSelection: $selection)
//        }
        .onPreferenceChange(TabBarItemPrefrenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

#Preview {
    CustomTabBarContainerView(selection: .constant(.home)) {
        Color.red
    }
}
