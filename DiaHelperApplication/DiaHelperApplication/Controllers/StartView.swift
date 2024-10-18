//
//  StartView.swift
//  DiaHelperApplication
//
//  Created by TumbaDev on 17.10.24.
//

import SwiftUI

struct StartView: View {
    var onLoginButtonTapped: () -> Void
    
    var body: some View {
        VStack {
            Image("startView")
            welcomeHeader
            actions
        }
        .padding()
        Spacer()
    }
    
    private var welcomeHeader: some View {
        Text("Welcome to DiaHelper!")
            .font(.system(size: 24))
            .foregroundColor(Color("newBlue"))
            .bold()
    }
    
    private var actions: some View {
        VStack {
            button(with: "Login", and: onLoginButtonTapped)
            button(with: "Register", and: {
                
            })
        }
    }
    
    private func button(with name: String, and action: @escaping () -> Void) -> some View {
        Button(name, action: action)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("newBlue"))
            .foregroundColor(Color("newBrown"))
            .cornerRadius(10)
    }
    
}
