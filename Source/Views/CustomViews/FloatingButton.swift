//
//  FloatingButton.swift
//  Parade
//
//  Created by Łukasz Szymczuk on 07/03/2023.
//

import SwiftUI

struct FloatingButton: View {
    let width: CGFloat = 100
    let onTap: ()->()
    @State var enabled: Bool
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            Group {
                Image(systemName: "repeat")
                    .resizable()
                    .foregroundColor(.black)
                    .padding()
            }
            .background(Color.white)
            .cornerRadius(width/2)
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 0)
            .padding()
            .frame(width: width, height: width)
            
        }
        .opacity(enabled ? 1.0 : 0.5)
        .disabled(!enabled)
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(onTap: {}, enabled: true)
    }
}
