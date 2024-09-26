//
//  CustomTF.swift
//  Solid Principle
//
//  Created by Kumar Basant on 22/07/24.
//

import SwiftUI
import Combine
struct CustomTF: View {
    @Binding var txtInput:String
    let palceHolder:String
    var isSecureText:Bool = false
    var keyboardType:UIKeyboardType = .default
    @FocusState private var isActive
    @Binding var showValidationText:Bool
    var imageName:String?
    var validationText:String
    var body: some View {
        ZStack{
            VStack(){
                HStack(alignment:.center){
                    Spacer()
                        .frame(width: 10)
                    Image(systemName: imageName!)
                        .frame(width: 20, height: 30)
                       // .padding(.leading,8)
                        .foregroundStyle(.gray)
                    TextField("",text: $txtInput)
                    //.padding(.leading,2)
                       // .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .focused($isActive)
                        .keyboardType(keyboardType)
                    
                        .onChange(of: txtInput){
                            if txtInput.isEmpty{
                            showValidationText = true
                        }else{
                            showValidationText = false
                        }
                        }
//                        .onReceive(Just(txtInput)) { _ in
//                            if txtInput.isEmpty{
//                                showValidationText = true
//                            }else{
//                                showValidationText = false
//                            }
//                        }
                        //.background(.green)
                    Spacer()
                    
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
            HStack(){
                Text(palceHolder)
                    .padding(.leading,(isActive || !txtInput.isEmpty) ? 15:35)
                   .offset(y:(isActive || !txtInput.isEmpty) ? -50 : (showValidationText || txtInput.isEmpty) ?  -13 : 0)
                    .foregroundStyle(isActive ? .secondary : .secondary )
                    .animation(.spring,value: isActive)
                   
                    .onTapGesture {
                        isActive.toggle()
                    }
                Spacer()
            }
            
        }
        .padding()
    }
}

#Preview {
    CustomTF(txtInput: .constant("Email"), palceHolder: "Email",showValidationText: .constant(false), validationText: "Please enter dash field")
}
