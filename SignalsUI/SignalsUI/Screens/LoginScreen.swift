//
//  LoginScreen.swift
//  SignalsUI
//
//  Created by Martin Klöppner on 9/19/23.
//

import SwiftUI
import Signals
import SignalUI

struct LoginScreen: View {
    
    @EnvironmentObject var session: Signal<SessionState>
    
    @ObservedObject var name = MutableSignal<String>("")
    @ObservedObject var password = MutableSignal<String>("")
    @ObservedObject var showPassword = MutableSignal<Bool>(false)

    @ObservedObject var isSignInButtonDisabled: Signal<Bool>
    
    init(name: MutableSignal<String> = MutableSignal<String>(""), password: MutableSignal<String> = MutableSignal<String>(""), showPassword: MutableSignal<Bool> = MutableSignal<Bool>(false)) {
        self.name = name
        self.password = password
        self.showPassword = showPassword
        self.isSignInButtonDisabled = computed { ctx in
            return name.fn(ctx).isEmpty || password.fn(ctx).isEmpty
        }
    }
    
    @ViewBuilder var body: some View {
        createSignalUI { ctx in
            VStack(alignment: .leading, spacing: 15) {
                Spacer()
                if (self.session.fn(ctx).isLoggedIn) {
                    Text("Logged In")
                }
                
                TextField("Name",
                          text: ReadWriteBinding(self.name).fn() ,
                          prompt: Text("Login").foregroundColor(.blue)
                )
                .autocapitalization(.none)
                .id("username")
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)
                
                HStack {
                    Group {
                        if showPassword.fn(ctx) {
                            TextField("Password", // how to create a secure text field
                                      text: ReadWriteBinding(self.password).fn(),
                                      prompt: Text("Password")
                                .foregroundColor(.red))
                            .autocapitalization(.none) // How to change the color of the TextField Placeholder
                            .id("password")
                        } else {
                            SecureField("Password", // how to create a secure text field
                                        text: ReadWriteBinding(self.password).fn(),
                                        prompt: Text("Password")
                                .foregroundColor(.red)) // How to change the color of the TextField Placeholder
                            .id("password")
                        }
                    }
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.red, lineWidth: 2) // How to add rounded corner to a TextField and change it colour
                    }
                    
                    Button {
                        showPassword.mutate(!showPassword.value)
                    } label: {
                        Image(systemName: showPassword.fn(ctx) ? "eye.slash" : "eye")
                            .foregroundColor(.red) // how to change image based in a State variable
                    }
                    
                }.padding(.horizontal)
                
                Spacer()
                
                Button {
                    (self.session as? MutableSignal<SessionState>)?.mutate(SessionState(isLoggedIn: true, user: User(id: UUID().uuidString, username: "Franz", birthdate: MutableSignal(1980))))
                } label: {
                    Text("Sign In")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(height: 50)
                .frame(maxWidth: .infinity) // how to make a button fill all the space available horizontaly
                .background(
                    isSignInButtonDisabled.fn(ctx) ? // how to add a gradient to a button in SwiftUI if the button is disabled
                    LinearGradient(colors: [.gray], startPoint: .topLeading, endPoint: .bottomTrailing) :
                        LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(20)
                .disabled(isSignInButtonDisabled.fn(ctx)) // how to disable while some condition is applied
                .padding()
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
