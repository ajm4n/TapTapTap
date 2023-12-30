//
//  ContentView.swift
//  watchSendTap
//
//  Created by ajman on 12/12/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var pairingManager = PairingManager
    @State private var showErrorPopup: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationView {
            VStack {
                if let code = pairingManager.currentPairingCode {
                    Text("Your Pairing Code:")
                        .font(.headline)
                        .padding(.bottom, 5)

                    Text(code)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.bottom, 20)
                }

                Button(action: {
                    if pairingManager.pairedDevices.isEmpty {
                        errorMessage = "Please pair with another device first."
                        showErrorPopup.toggle()
                    } else {
                        // Add logic to send vibrations
                        print("Sending vibrations...")
                    }
                }) {
                    Text("Send Vibrations")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .cornerRadius(8)
                        .padding(.bottom, 10)
                }

                Button(action: {
                    pairingManager.register { success in
                        if success {
                            print("Registration successful!")
                        } else {
                            showErrorPopup.toggle()
                        }
                    }
                }) {
                    Text("Register")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(8)
                        .padding(.bottom, 10)
                }

                NavigationLink(destination: SenderView(pairingManager: pairingManager)) {
                    Text("Send Vibration")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.bottom, 10)
                }

                NavigationLink(destination: ReceiverView(pairingManager: pairingManager)) {
                    Text("Receive Vibration")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(8)
                        .padding(.bottom, 10)
                }

                NavigationLink(destination: PairingView(pairingManager: pairingManager)) {
                    Text("Pair Another App")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(8)
                }
            }
            .padding()
            .navigationTitle("Vibration App")
            .alert(isPresented: $showErrorPopup) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}
