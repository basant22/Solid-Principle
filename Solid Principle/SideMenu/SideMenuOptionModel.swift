//
//  SideMenuOptionModel.swift
//  Solid Principle
//
//  Created by Kumar Basant on 22/07/24.
//

import Foundation
enum SideMenuOptionModel:Int,CaseIterable{
    case dashboard = 0
    case profile
    case address
    case search
    case language
    var title:String{
        switch self {
        case .dashboard:
            "Dashboard"
        case .profile:
            "Profile"
        case .address:
            "Address"
        case .search:
            "Search"
        case .language:
            "Language"
        }
    }
    var systemImageName:String{
        switch self {
        case .dashboard:
            "filemenu.and.cursorarrow"
        case .profile:
            "person"
        case .address:
            "paperplane"
        case .search:
            "magnifyingglass"
        case .language:
            "switch.2"
        }
    }
}

extension SideMenuOptionModel:Identifiable{
    var id:Int{
        return self.rawValue
    }
}
