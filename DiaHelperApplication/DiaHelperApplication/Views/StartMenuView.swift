//
//  StartMenuView.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 5.11.24.
//

import SwiftUI

struct StartMenuView: View {
    @Binding var path: NavigationPath
    @State private var isHeaderVisible = false
    @State private var isContentVisible = false
    @State private var isSubscribed = false

    var body: some View {
        VStack {
            VStack(spacing: 10) {
                welcomeimage
                welcomeHeader
                MenuItemView(title: "Login", iconName: "person") {
                    path.append(Destination.login)
                }
                MenuItemView(title: "Register", iconName: "person.badge.plus") {
                    path.append(Destination.register)
                }
                VStack(spacing: 10){
                    DarkModeToggleView()
                        .padding(.horizontal)
                    
                    HStack {
                        subText
                        Spacer()
                        subImage
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                }

            }
            .padding(.top)
            .offset(y: isContentVisible ? 0 : 50)
            .opacity(isContentVisible ? 1 : 0)
            .onAppear {
                withAnimation(.easeOut(duration: 1)) {
                    isContentVisible = true
                }
            }
            Spacer()
        }
        .padding(.top, 20)
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
            .opacity(isHeaderVisible ? 1 : 0)
            .offset(y: isHeaderVisible ? 0 : 20)
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    isHeaderVisible = true
                }
            }
    }
    
    private var subText: some View {
        Text("Subscribed")
            .bold()
            .opacity(isSubscribed ? 1.0 : 0.5)
    }
    
    private var subImage: some View {
        Image(systemName: isSubscribed ? "checkmark.circle.fill" : "circle")
            .font(.system(size: 24))
            .foregroundColor(isSubscribed ? .green : .black)
            .scaleEffect(isSubscribed ? 1.25 : 1.0)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 1.0)) {
                    isSubscribed.toggle()
                }
            }
    }
}

struct DarkModeToggleView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        HStack {
            Toggle(isOn: $isDarkMode.animation(.easeInOut(duration: 0.5))) {
                Text("Dark Mode")
                    .font(.headline)
                    .opacity(isDarkMode ? 1.0 : 0.5)
            }
            .toggleStyle(SwitchToggleStyle(tint: .blue))
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct MenuItemView: View {
    let title: String
    let iconName: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .frame(width: 24, height: 24)
                .foregroundColor(.blue)
            Text(title)
                .font(.headline)
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .onTapGesture {
            action()
        }
        .padding(.horizontal)
    }
}
