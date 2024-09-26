//
//  ContentView.swift
//  Solid Principle
//
//  Created by Kumar Basant on 10/07/24.
//

import SwiftUI

struct ContentView: View {
   
    
    
   
    @State private var showMenu = false
    @State private var selectedTab = 0
    
    @EnvironmentObject private var router:Router
    
    var body: some View {
        ZStack{
            CommentSearch(showMenu: $showMenu)
          /*  TabView(selection:$selectedTab){
                CommentSearch()
                    .tag(0)
                Text("Profile")
                    .tag(1)
                MapView()
                    .tag(2)
                Text("Search")
                    .tag(3)
                Text("Language")
                    .tag(4)
            }
        
            */
     
            SideMenu(isShowing: $showMenu, selectedTab: $selectedTab)
        }
        
       // .padding()
        
        
    }
    
    
    
}

#Preview {
    ContentView()
}

struct CommentSearch: View {
    @StateObject var viewModel = CommentViewModel()
    @Namespace private var viewAnimation
    @Namespace private var imgSpace
    @Namespace private var txt1space
    @Namespace private var txt2space
    @State private var searchText:String = ""
    @State private var isExpand = false
    @Binding var showMenu:Bool
    
    //var filteredList:[Comments] = []
    var filteredList:[Comments]{
        guard !searchText.isEmpty else {return viewModel.comments }
        return viewModel.comments.filter({$0.name.localizedCaseInsensitiveContains(searchText)})
    }
    var body: some View {
        ScrollView{
            VStack{
                if isExpand {expandView}else{ collapsedView}
                
                ForEach(filteredList,id: \.id){ comment in
                    VStack{
                        Text(comment.name)
                        Text(comment.email)
                        Text(comment.commentCreated?.toString() ?? "")
                    }
                    .padding(.vertical,5)
                }
                .searchable(text: $searchText,placement:
                        .navigationBarDrawer(displayMode: .always),prompt: "Serach")
                
            }
        }
        .padding()
        .animation(.linear,value: showMenu)
        .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                HStack{
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .frame(width: 25,height: 18)
                        .foregroundColor(.green)
                        .onTapGesture {
                            withAnimation {
                               // router.path.removeLast()
                                showMenu.toggle()
                            }
                        }
                   // Text("Home")
                     //   .foregroundColor(.green)
                      //  .font(.title2).bold()
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            Task{
                viewModel.getComments()
                //await viewModel.getCommentsAsync()
            }
        }
    }
    var collapsedView: some View {
        HStack(){
           profileImage
                .frame(width: 40, height: 40)
                .matchedGeometryEffect(id: imgSpace, in: viewAnimation)
            VStack(alignment: .leading){
                Text("Kumar Basant")
                    .font(.title).bold()
                    .matchedGeometryEffect(id: txt1space, in: viewAnimation)
                Text("IOS Developer")
                    .foregroundColor(.secondary)
                    .matchedGeometryEffect(id: txt2space, in: viewAnimation)
                   // .font(.title).bold()
            }
            Spacer()
        }
    }
    var expandView: some View {
        VStack{
            profileImage
                 .frame(width: 120, height: 120)
                 .matchedGeometryEffect(id: imgSpace, in: viewAnimation)
                 Text("Kumar Basant")
                     .font(.title).bold()
                     .matchedGeometryEffect(id: txt1space, in: viewAnimation)
                 Text("IOS Developer")
                     .foregroundColor(.secondary)
                     .matchedGeometryEffect(id: txt2space, in: viewAnimation)
        }
    }
    var profileImage: some View {
        VStack{
            Image("Photos")
                .resizable()
                .clipShape(Circle())
                .onTapGesture {
                    withAnimation(.spring){
                        isExpand.toggle()
                    }
                }
        }
    }
}
