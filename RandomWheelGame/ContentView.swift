//
//  ContentView.swift
//  RandomWheelGame
//
//  Created by Jero on 2022/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var count: Int = 7
    var colors: [Color] = [.orange, .red, .green, .blue, .mint, .cyan, .purple, .brown]
    let calculate: CalculateAngle = CalculateAngle()
    @State private var rotation: Int = 0
    @State private var isAnimating = false
    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                let startPoint = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                let result = calculate.CalculateAngleDegrees(count)
                
                ZStack {
                    ForEach(0 ..< count, id: \.self) { num in
                        Path { path in
                            path.move(to: startPoint)
                            path.addArc(
                                center: startPoint,
                                radius: 150,
                                startAngle: .degrees(result.startAngleArray[num]),
                                endAngle: .degrees(result.endAngleArray[num]), clockwise: true)
                        }
                        .fill(colors[num])
                        .overlay(
                            Text("범석")
                                .font(.system(.largeTitle, design: .rounded))
                                .bold()
                                .foregroundColor(.black)
                                .offset(x: 75, y: 5))
                        .rotationEffect(
                            Angle(
                                degrees:  self.isAnimating ? 360 : 0
                            )
                        )
                        .animation(self.isAnimating ? foreverAnimation : .easeInOut)
                    }
                }
                
            }
            Button(
                action: {
                    self.isAnimating.toggle()
                },
                label: {
                    Text("돌려 돌려")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                    //                            .rotationEffect(
                    //                                Angle(
                    //                                    degrees:  self.isAnimating ? 360 : 0
                    //                                )
                    //                            )
                    //                            .animation(self.isAnimating ? foreverAnimation : .default)
                }
            )
            .background(.blue)
            .padding()
            .padding()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
