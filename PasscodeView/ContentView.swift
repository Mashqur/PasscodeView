//
//  ContentView.swift
//  PasscodView
//
//  Created by Mashqur Habib Himel on 15/2/25.
//

import SwiftUI

struct ContentView: View {
    
    var passcode: String = "1234"
    @State var selectedPasscode: String = ""
    @State var filledCircle: Int = 0
    @State private var shakes: CGFloat = 0
    
    var body: some View {
        VStack {
            Image(systemName: "lock")
                .font(.title)
                .foregroundStyle(.cyan)
                .padding()
                .symbolEffect(.pulse, options: .repeating)
                .modifier(ShakeEffect(animatableData: shakes))
                
            
            Text("Enter Your Passcode")
                .foregroundStyle(.cyan)
                .fontDesign(.serif)
                .font(.title2)
                .padding()
            HStack(content: {
                ForEach(0..<4) { index in
                    Circle()
                        .fill(index < filledCircle ? Color.cyan.opacity(0.5) : .clear)
                        .stroke(.cyan, style: StrokeStyle(lineWidth: 1))
                        .frame(width: 15, height: 15)
                        .padding()
                }
                
            })
            .modifier(ShakeEffect(animatableData: shakes))
            
            Grid(horizontalSpacing: 25, verticalSpacing: 25) {
                ForEach(0..<3) { rowIndex in
                    GridRow {
                        ForEach(0..<3) { columIndex in
                            let buttonNumber = (rowIndex * 3) + (columIndex + 1)
                            buttonCell(int: buttonNumber)
                        }
                    }
                }
            }
            .padding(.top, 20)
            
            buttonCross()
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .background(.cyan.opacity(0.4))
        
    }
    
    private func buttonCell(int: Int) -> some View {
        Button(action: {
            let num = String(int)
            if selectedPasscode.count <= 3 {
                selectedPasscode.append(num)
            }
            
            if filledCircle < 4 {
                filledCircle += 1
                if filledCircle == 4 {
                    if selectedPasscode == passcode {
                        selectedPasscode = ""
                    } else {
                        withAnimation(.linear(duration: 0.5)) {
                            shakes += 1
                        }
                        selectedPasscode = ""
                        filledCircle = 0
                    }
                }
            }

            
        }, label: {
            Text("\(int)")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding()
        })
        .frame(width: 60, height: 60)
        .background(LinearGradient(gradient: Gradient(colors: [.cyan.opacity(0.5), .cyan.opacity(0.1)]), startPoint: .leading, endPoint: .trailing))
        .clipShape(Circle())
        
    }
    
    private func buttonCross() -> some View {
        Button(action: {
            filledCircle = 0
        }, label: {
            Image(systemName: "multiply")
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
        })
        .frame(width: 60, height: 60)
        .background(LinearGradient(gradient: Gradient(colors: [.cyan.opacity(0.5), .cyan.opacity(0.1)]), startPoint: .leading, endPoint: .trailing))
        .clipShape(Circle())
    }
}

#Preview {
    return ContentView()
}


struct ShakeEffect: GeometryEffect {
    var amount: CGFloat = 5
    var shakesPerUnit = 6
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(
            CGAffineTransform(translationX: amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)), y: 0)
        )
    }
}
