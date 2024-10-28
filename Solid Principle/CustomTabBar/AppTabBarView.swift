//
//  AppTabBarView.swift
//  Solid Principle
//
//  Created by Kumar Basant on 24/10/24.
//

import SwiftUI

struct AppTabBarView: View {
    @State private var isSelected:Bool = false
    @State private var tabSelection:TabBarItem = .home
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.red
                .tabBarItem(tab: .home, selection: $tabSelection)
               // .tabBarItem(tab: TabBarItem(tabIcon: "house", title: "Home", color: Color.red),selection: $tabSelection)
            Color.blue
                .tabBarItem(tab: .favirite, selection: $tabSelection)
                //.tabBarItem(tab: TabBarItem(tabIcon: "heart", title: "Favorites", color: Color.blue),selection: $tabSelection)
            Color.green
                .tabBarItem(tab: .profile, selection: $tabSelection)
              //  .tabBarItem(tab: TabBarItem(tabIcon: "person", title: "Person", color: Color.green),selection: $tabSelection)
        }
    }
}

#Preview {
    AppTabBarView()
}
extension AppTabBarView{
    private var defaultView:some View{
        TabView(selection: $isSelected) {
            Color.red.tabItem {
                Image(systemName: "house")
                Text("Home")
            }.tag(1)
            Color.blue.tabItem {
                Image(systemName: "heart")
                Text("Favorites")
            }.tag(2)
            Color.green.tabItem {
                Image(systemName: "person")
                Text("Profile")
            }.tag(2)
        }
    }
}
