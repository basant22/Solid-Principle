//
//  LoginView.swift
//  Solid Principle
//
//  Created by Kumar Basant on 18/07/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(RouterNew.self)  private var routee
    @EnvironmentObject private var router:Router
    @State private var txtLogin:String = ""
    @State private var txtPassword:String = ""
    @State private var fstate = true
    @State private var showUserIdValidationText = false
    @State private var showPasswordValidationText = false
    
    var body: some View {
        @Bindable var route = routee
        NavigationStack(path:$route.routes){
            //  GeometryReader{ viewSpace in
            ScrollView{
            VStack(alignment: .center){
                SpinningImageView()
                    .padding()
                VStack(spacing: 10){
                    CustomTF(txtInput: $txtLogin, palceHolder: "Login",isSecureText: false,showValidationText: $showUserIdValidationText, imageName:"person",validationText:"Please enter your user-Id.")
                    CustomPF(txtInput: $txtPassword, palceHolder: "Password",showValidationText: $showPasswordValidationText,validationText:"Please enter valid password")
                    
                }
                .padding()
                Spacer()
                   // .frame(height: 20)
                Button {
                    route.routes.append(.home)
                    //router.path.append("ToHome")
                } label: {
                    Text("Forgot Password")
                        .frame(height: 50)
                        .font(.title2)
                        .foregroundStyle(Color.gray)
                        .underline()
                        .padding(.top,40)
//                        .background(
//                            RoundedRectangle(
//                                cornerRadius: 12.0,
//                                style: .continuous )
//                            .fill(Color.green))
                    
                }
                Spacer()
                Button {
                    //route.routes.append(.home)
                    if txtLogin.isEmpty{
                        showUserIdValidationText = true
                    }else if txtPassword.isEmpty{
                        showPasswordValidationText = true
                    }
                    else{
                        route.routes.append(.calculater)
                    }
                    //route.routes.append(.calculater)
                    //router.path.append("ToHome")
                } label: {
                    Text("Login")
                        .frame(width: 300, height: 50)
                        .font(.title2)
                        .foregroundStyle(Color.white)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 12.0,
                                style: .continuous )
                            .fill(Color.green))
                        .padding(.top,40)
                    
                }
                Button {
                    route.routes.append(.signup)
                   
                    // router.path.append("ToRegister")
                } label: {
                    HStack(spacing:5){
                        Spacer()
                        Text("Register Here")
                        //.frame(maxWidth: .infinity)
                            .frame(height: 30)
                            .font(.title2)
                            .foregroundStyle(Color.green)
                        
                        Image(systemName:"chevron.forward.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .imageScale(.small)
                            .clipShape(Circle())
                            .foregroundStyle(.green)
                            .background(.white)
                        //  .padding(.trailing)
                        Spacer()
                    }
                    .padding(.top,40)
                }
              //  Spacer()
                    //.frame(height: 10)
            }
           // .padding(.top,5)
            //.padding(.bottom,15)
             }
            .navigationTitle("Login")
            .navigationDestination(for: Route.self){ route in
                route.destination
            }
            /*.navigationDestination(for: String.self){ values in
             if values == "ToHome"{
             ContentView()
             }else if values == "ToMap"{
             MapViewContent()
             }else if values == "ToRegister"{
             SignupView()
             }
             }*/
        }
    }
}

#Preview {
    LoginView()
        .environment(RouterNew())
}
