//
//  ContentView.swift
//  Parade
//
//  Created by Łukasz Szymczuk on 06/03/2023.
//

import SwiftUI
import CoreParade

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
