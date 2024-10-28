//
//  CustomPF.swift
//  Solid Principle
//
//  Created by Kumar Basant on 08/08/24.
//

import SwiftUI
import Combine
import BGUtilityIos
struct CustomPF: View {
    @Binding var txtInput:String
    let palceHolder:String
    var keyboardType:UIKeyboardType = .default
    @State private  var isShow = true
    @FocusState private var isActive
    @Binding var showValidationText:Bool
    var validationText:String
    var body: some View {
        ZStack(){
            VStack{
                HStack{
                    Image(systemName: "lock")
                        .frame(width: 20, height: 30)
                        .foregroundStyle(.gray)
                        .padding(.leading,8)
                    if isShow{
                        SecureField("",text: $txtInput)
                        // .padding(.leading,3)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .focused($isActive)
                            .keyboardType(keyboardType)
                            .onChange(of: txtInput, { oldValue, newValue in
                                debugPrint("oldValue=\(oldValue)")
                                debugPrint("newValue=\(newValue)")
                                if newValue.isEmpty {
                                    showValidationText = true
                                }else{
                                    showValidationText = false
                                }
                            })
//                            .onReceive(Just(txtInput)) { _ in
//                                if txtInput.isEmpty{
//                                    showValidationText = true
//                                }else{
//                                    showValidationText = false
//                                }
//                            }
                        
                    }else{
                        TextField("",text: $txtInput)
                        //.padding(.leading)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .focused($isActive)
                            .keyboardType(keyboardType)
//                            .onReceive(Just(txtInput)) { _ in
//                                if txtInput.isEmpty{
//                                    showValidationText = true
//                                }else{
//                                    showValidationText = false
//                                }
//                            }
                    }
                    Image(systemName:isShow ? "eye.slash":"eye")
                        .foregroundStyle(.gray)
                        .frame(width: 30, height: 30)
                        .padding(.trailing,8)
                    
                        .onTapGesture {
                            withAnimation(.easeInOut){
                                isShow.toggle()
                            }
                        }
                }
                .background(.gray.opacity(0.30),in:.rect(cornerRadius: 16))
                if showValidationText {
                    HStack{
                        Spacer()
                            .frame(width: 10)
                        Text(validationText)
                            .font(.footnote)
                            .foregroundStyle(.red.opacity(0.85))
                        Spacer()
                    }
                }else{
                    HStack{
                        Spacer()
                            .frame(width: 10)
                        Text("")
                            .font(.footnote)
                            .foregroundStyle(.red.opacity(0.85))
                        Spacer()
                    }
                }
            }
            HStack{
                Text(palceHolder)
                    .padding(.leading,(isActive || !txtInput.isEmpty) ? 15:35)
                    .offset(y:(isActive || !txtInput.isEmpty)  ? -50 :(showValidationText || txtInput.isEmpty) ?  -13 : 0)
                    .foregroundStyle(isActive ? .secondary : .secondary )
                // .foregroundStyle(isActive ? .black : .secondary )
                    .animation(.spring,value: isActive)
                    .onTapGesture {
                        isActive.toggle()
                    }
                Spacer()
            }
        }
        .onAppear{
           // let networ = BGNetwork()
        }
        .padding()
    }
}

#Preview {
    CustomPF(txtInput: .constant("Password"), palceHolder: "Password",showValidationText: .constant(false),validationText: "Please enter password")
}
