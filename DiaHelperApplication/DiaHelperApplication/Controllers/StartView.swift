//
//  StartView.swift
//  DiaHelperApplication
//
//  Created by TumbaDev on 17.10.24.
//

import SwiftUI

struct StartView: View {
    var onLoginButtonTapped: () -> Void
    var onRegisterButtonTapped: () -> Void
    
    var body: some View {
        VStack {
            welcomeimage
            welcomeHeader
            actions
            Spacer()
        }
        .padding()
        .background(Color("background"))
    }
    
    private var welcomeimage: some View {
        Image("startView")
            .padding(.top, 16)
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
            button(with: "Register", and: onRegisterButtonTapped)
        }
    }
    
    private func button(with name: String, and action: @escaping () -> Void) -> some View {
        Button(action: action, label: {
            Text(name)
                .frame(maxWidth: .infinity)
        })
            .padding(10)
            .background(Color("buttonColor"))
            .contentShape(Rectangle())
            .foregroundColor(Color("newBrown"))
            .cornerRadius(10)
    }
    
}

#Preview {
    StartView(onLoginButtonTapped: {
        
    }, onRegisterButtonTapped: {
        
    })
}
