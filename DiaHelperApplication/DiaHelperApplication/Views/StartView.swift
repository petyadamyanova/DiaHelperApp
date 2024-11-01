//
//  StartView.swift
//  DiaHelperApplication
//
//  Created by TumbaDev on 17.10.24.
//

import SwiftUI

struct StartView: View {
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
            button(with: "Login", to: LoginView())
            button(with: "Register", to: RegisterView())
        }
    }
    
    private func button<Destination: View>(with name: String, to destination: Destination) -> some View {
        NavigationLink(destination: destination) {
            Text(name)
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(Color("buttonColor"))
                .foregroundColor(Color("newBrown"))
                .cornerRadius(10)
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    StartView()
}
