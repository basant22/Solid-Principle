//
//  SignupView.swift
//  Solid Principle
//
//  Created by Kumar Basant on 23/07/24.
//

import SwiftUI

struct SignupView: View {
    @Environment(RouterNew.self)  private var routee
    @State private var txtName:String = ""
    @State private var txtMobile:String = ""
    @State private var txtEmail:String = ""
    @State private var txtPassword:String = ""
    @State private var txtConfirmPassword:String = ""
    @State private var showNameValidationText:Bool = false
    @State private var showNumberValidationText:Bool = false
    @State private var showEmailValidationText:Bool = false
    @State private var showPasswordValidationText:Bool = false
    @State private var showConfirmPasswordValidationText:Bool = false
    @EnvironmentObject var router:Router
    var body: some View {
        @Bindable var route = routee
          ScrollView{
            VStack(spacing:10){
                CustomTF(txtInput: $txtName, palceHolder: "Name",showValidationText: $showNameValidationText, imageName:"person",validationText:"Please enter your name.")
                CustomTF(txtInput: $txtMobile, palceHolder: "Mobile Number",keyboardType: .numberPad,showValidationText: $showNumberValidationText, imageName:"apps.iphone", validationText: "Please enter your mobile number.")
                CustomTF(txtInput: $txtEmail, palceHolder: "Email Id",keyboardType: .emailAddress,showValidationText: $showEmailValidationText, imageName:"square.and.pencil", validationText: "Please enter your email Id.")
                CustomPF(txtInput: $txtPassword, palceHolder: "Password",showValidationText: $showPasswordValidationText,validationText:"Please enter valid password")
                CustomPF(txtInput: $txtConfirmPassword, palceHolder: "Confirm Password",showValidationText: $showConfirmPasswordValidationText,validationText:"Please enter confirm password")
                    Spacer()
                    Button {
//                        if txtName.isEmpty{
//                            showNameValidationText = true
//                        }else if txtMobile.isEmpty{
//                            showNumberValidationText = true
//                        }else if txtEmail.isEmpty{
//                            showEmailValidationText = true
//                        }else{
//                            route.routes.append(.map)
//                        }
                        route.routes.append(.map)
                       // router.path.removeLast()
                    } label: {
                        Text("Register")
                            .frame(width: 300, height: 50)
                            .font(.title2)
                            .foregroundStyle(Color.white)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12.0,
                                    style: .continuous )
                                .fill(Color.green))

                    }
            }
            .padding()
            
        }
            .navigationTitle("Register")
            //.navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        route.routes.removeLast()
                        route.routes.append(.map)
                       // router.path.removeLast()
                    }label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .imageScale(.small)
                            .frame(width: 12, height: 18)
                            .foregroundStyle(.green)
                        
                    }
                }
            }
    }
}

#Preview {
    SignupView()
}
