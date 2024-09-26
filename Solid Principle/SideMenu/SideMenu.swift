//
//  SideMenu.swift
//  Solid Principle
//
//  Created by Kumar Basant on 22/07/24.
//

import SwiftUI

struct SideMenu: View {
    @Binding var isShowing:Bool
    @Binding var selectedTab:Int
    @State private var selectedOption:SideMenuOptionModel?
    @EnvironmentObject var router:Router
    @Environment(RouterNew.self) private var routee
  //  @Binding var title:String
    var body: some View {
       
        ZStack{
            if isShowing{
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                HStack{
                    VStack(alignment:.leading,spacing: 32){
                        SideMenuHeaderView()
                        VStack{
                            ForEach(SideMenuOptionModel.allCases){ menu in
                                Button{
                                    selecteMenu(menu)
                                }label: {
                                    SideMenuRowView(option: menu, selectedOption: $selectedOption )
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(width: 270,alignment: .leading)
                    .background(.teal)
                    Spacer()
                }
                .transition(.move(edge:.leading))
            }
        }
        
        .animation(.easeInOut,value: isShowing)
    }
    func selecteMenu(_ menu:SideMenuOptionModel){
        @Bindable var route = routee
        selectedOption = menu
        selectedTab = menu.rawValue
       // title = menu.title
        isShowing = false
      //  router.path.removeLast()
        route.routes.removeLast()
        switch menu {
        case .dashboard:
            route.routes.append(.home)
          //  router.path.append("ToHome")
        case .profile:
           // route.routes.append(.home)
            debugPrint("Profile")
        case .address:
            route.routes.append(.map)
           // router.path.append("ToMap")
        case .search:
            debugPrint("Search")
        case .language:
            debugPrint("Search")
        }
    }
}

#Preview {
    SideMenu(isShowing: .constant(true), selectedTab: .constant(0))
}
