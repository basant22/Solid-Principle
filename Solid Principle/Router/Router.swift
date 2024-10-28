//
//  Router.swift
//  Solid Principle
//
//  Created by Kumar Basant on 18/07/24.
//


enum Route:Hashable{
    case map
    case signup
    case home
    case calculater
    case tabView
    
    enum Patient:Hashable{
        case create
        case list
        case detail
        @ViewBuilder
        var destination:some View{
            switch self {
            case .create:
                Text("Create Patient")
            case .list:
                Text("Create List")
            case .detail:
                Text("Create Detail")
            }
        }
    }
    
    @ViewBuilder
    var destination:some View{
        switch self {
        case .map:
            //MapView(showMenu: .constant(true))
            MapViewContent()
        case .signup:
            SignupView()
        case .home:
            ContentView()
        case .calculater:
            CalculatorView()
        case .tabView:
            AppTabBarView()
        }
    }
}

import SwiftUI
class Router:ObservableObject{
    @Published var path = NavigationPath()
    
    
    
}

@Observable
class RouterNew{
    var routes:[Route] = []
}
