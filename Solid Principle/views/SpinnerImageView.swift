//
//  SpinnerImageView.swift
//  Solid Principle
//
//  Created by Kumar Basant on 18/07/24.
//

import SwiftUI

struct SpinningImageView: View {
    @State private var rotationAngle: Double = 0
    @State private var rotationAngle1: Double = 0

    var body: some View {
       
            VStack{
                    Image("Photos") // Replace with your image name
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                     .frame(width: 100, height: 100) // Set your desired frame size
                        .clipShape(Circle()) // Make the image circular
                        .rotationEffect(Angle(degrees: rotationAngle1))
                        .onAppear {
                            withAnimation(Animation.linear(duration: 10.0).repeatForever(autoreverses: false)) {
                                rotationAngle1 = 360
                            }
                        }
            
                }
 
    }
}

#Preview {
    SpinningImageView()
}
