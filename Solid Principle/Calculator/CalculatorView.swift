//
//  CalculatorView.swift
//  Solid Principle
//
//  Created by Kumar Basant on 08/08/24.
//

import SwiftUI

struct CalculatorView: View {
    @State private var num1:String = "0"
    @State private var opr:String = ""
    @State private var num2:String = ""
    @State private var result:String = "0"
    var body: some View {
        
        GeometryReader { geo in
            
            VStack(){
                
                VStack(){
                    Spacer()
                    Text(result)
                        .font(.system(size: 60))
                        .fontWeight(.regular)
                        .frame(maxWidth :.infinity,alignment: .trailing)
                        .frame(height:100)
                    
                }
                .padding()
                Spacer()
                VStack(alignment:.center){
                    HStack(){
                        Button {
                            result = "0"
                            num1 = ""
                            num2 = ""
                            opr = ""
                        }label: {
                            Text("AC")
                            
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.gray.opacity(0.4)))
                            
                        }
                        Button(action: {
                            if num1 == result{
                                if num1.isEmpty{
                                    num1 = "-" + "0"
                                }else if num1.contains("-"){
                                    let char = num1.dropFirst()
                                    //num1.remove(at: num1.startIndex)
                                    num1 = String(char)
                                }else{
                                    num1 = "-" + num1
                                }
                                result = num1
                            }else{
                                if num2.isEmpty{
                                    num2 = "-" + "0"
                                }else if num2.contains("-"){
                                    let char = num2.remove(at: num2.startIndex)
                                    num2 = String(char)
                                }else{
                                    num2 = "-" + num2
                                }
                                result = num2
                            }
                        }, label: {
                            Image(systemName: "plus.forwardslash.minus")
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.gray.opacity(0.4)))
                            
                        })
                        /* ZStack{
                         VStack{
                         
                         }
                         .frame(width: geo.size.width/4-15, height: geo.size.width/4-15)
                         .background(
                         RoundedRectangle(
                         cornerRadius: (geo.size.width/4-15)/2,
                         style: .continuous )
                         .fill(Color.gray.opacity(0.4)))
                         
                         }*/
                        Button(action: {
                            opr = "%"
                            
                        }, label: {
                            Image(systemName: "percent")
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.gray.opacity(0.4)))
                            
                        })
                        Button(action: {
                            opr = "/"
                            result = ""
                        }, label: {
                            Image(systemName: "divide")
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.orange.opacity(0.75)))
                            
                        })
                        
                    }
                    HStack{
                        Button(action: {
                            if opr.isEmpty{
                                if num1.isEmpty || num1 == "0"{
                                    num1 = "7"
                                }else{
                                    num1 += "7"
                                }
                                result = num1
                            }else{
                                if num2.isEmpty{
                                    num2 = "7"
                                }else{
                                    num2 += "7"
                                }
                                result = num2
                            }
                        }, label: {
                            Text("7")
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.gray))
                            
                        })
                        
                        
                        Button(action: {
                            if opr.isEmpty{
                                if num1.isEmpty || num1 == "0"{
                                    num1 = "8"
                                }else{
                                    num1 += "8"
                                }
                                result = num1
                            }else{
                                if num2.isEmpty{
                                    num2 = "8"
                                }else{
                                    num2 += "8"
                                }
                                result = num2
                            }
                        }, label: {
                            Text("8")
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.gray))
                            
                        })
                        Button(action: {
                            if opr.isEmpty{
                                if num1.isEmpty || num1 == "0"{
                                    num1 = "9"
                                }else{
                                    num1 += "9"
                                }
                                result = num1
                            }else{
                                if num2.isEmpty{
                                    num2 = "9"
                                }else{
                                    num2 += "9"
                                }
                                result = num2
                            }
                        }, label: {
                            Text("9")
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.gray))
                            
                        })
                        Button(action: {
                            opr = "*"
                            result = ""
                        }, label: {
                            Image(systemName: "multiply")
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.orange.opacity(0.75)))
                            
                        })
                        
                    }
                    HStack{
                        Button(action: {
                            if opr.isEmpty{
                                if num1.isEmpty || num1 == "0"{
                                    num1 = "4"
                                }else{
                                    num1 += "4"
                                }
                                result = num1
                            }else{
                                if num2.isEmpty{
                                    num2 = "4"
                                }else{
                                    num2 += "4"
                                }
                                result = num2
                            }
                        }, label: {
                            Text("4")
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.gray))
                            
                        })
                        
                        
                        Button(action: {
                            if opr.isEmpty{
                                if num1.isEmpty || num1 == "0"{
                                    num1 = "5"
                                }else{
                                    num1 += "5"
                                }
                                result = num1
                            }else{
                                if num2.isEmpty{
                                    num2 = "5"
                                }else{
                                    num2 += "5"
                                }
                                result = num2
                            }
                        }, label: {
                            Text("5")
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.gray))
                            
                        })
                        Button(action: {
                            if opr.isEmpty{
                                if num1.isEmpty || num1 == "0"{
                                    num1 = "6"
                                }else{
                                    num1 += "6"
                                }
                                result = num1
                            }else{
                                if num2.isEmpty{
                                    num2 = "6"
                                }else{
                                    num2 += "6"
                                }
                                result = num2
                            }
                        }, label: {
                            Text("6")
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.gray))
                            
                        })
                        Button(action: {
                            opr = "-"
                            result = ""
                        }, label: {
                            Image(systemName: "minus")
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.orange.opacity(0.75)))
                            
                        })
                        
                    }
                    HStack{
                        Button(action: {
                            if opr.isEmpty{
                                if num1.isEmpty || num1 == "0"{
                                    num1 = "1"
                                }else{
                                    num1 += "1"
                                }
                                result = num1
                            }else{
                                if num2.isEmpty{
                                    num2 = "1"
                                }else{
                                    num2 += "1"
                                }
                                result = num2
                            }
                        }, label: {
                            Text("1")
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.gray))
                            
                        })
                        
                        
                        Button(action: {
                            if opr.isEmpty{
                                if num1.isEmpty || num1 == "0"{
                                    num1 = "2"
                                }else{
                                    num1 += "2"
                                }
                                result = num1
                            }else{
                                if num2.isEmpty{
                                    num2 = "2"
                                }else{
                                    num2 += "2"
                                }
                                result = num2
                            }
                        }, label: {
                            Text("2")
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.gray))
                            
                        })
                        Button(action: {
                            if opr.isEmpty{
                                if num1.isEmpty || num1 == "0"{
                                    num1 = "3"
                                }else{
                                    num1 += "3"
                                }
                                result = num1
                            }else{
                                if num2.isEmpty{
                                    num2 = "3"
                                }else{
                                    num2 += "3"
                                }
                                result = num2
                            }
                        }, label: {
                            Text("3")
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.gray))
                            
                        })
                        Button(action: {
                            opr = "+"
                            result = ""
                        }, label: {
                            Image(systemName: "plus")
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.orange.opacity(0.75)))
                            
                        })
                        
                    }
                    HStack{
                        Button {
                            if opr.isEmpty{
                                if num1.isEmpty || num1 == "0"{
                                    num1 = "0"
                                }else{
                                    num1 += "0"
                                }
                                result = num1
                            }else{
                                if num2.isEmpty{
                                    num2 = "0"
                                }else{
                                    num2 += "0"
                                }
                                result = num2
                            }
                        } label: {
                            Text("0")
                                .frame(width: 2*abs(geo.size.width/4-15), height: abs(geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.gray))
                            
                        }
                        
                        
                        
                        Button{
                            if opr.isEmpty{
                                if num1.isEmpty || num1 == "0"{
                                    num1 = "."
                                }else{
                                    num1 += "."
                                }
                                result = num1
                            }else{
                                if num2.isEmpty{
                                    num2 = "."
                                }else{
                                    num2 += "."
                                }
                                result = num2
                            }
                        }label: {
                            Text(".")
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.gray))
                            
                        }
                        Button{
                            let expression = num1 + opr + num2
                            let mathExpression = NSExpression(format: expression)
                            if let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? NSNumber {// 3
                                let resultString = formateResult(result: mathValue.doubleValue)
                                num1 = resultString
                                result = resultString
                                num2 = ""
                            }
                        }label: {
                            Image(systemName: "equal")
                                .frame(width:abs( geo.size.width/4-15), height: abs( geo.size.width/4-15))
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: (geo.size.width/4-15)/2,
                                        style: .continuous )
                                    .fill(Color.orange.opacity(0.75)))
                            
                        }
                        
                    }
                }
                .padding()
                //.background(.gray.opacity(0.06))
            }
        }
    }
    func formateResult(result:Double)->String{
        if (result.truncatingRemainder(dividingBy: 1)==0){
            return String(format:"%.0f",result)
        }else{
            return String(format:"%.2f",result)
        }
    }
}

#Preview {
    CalculatorView()
}
