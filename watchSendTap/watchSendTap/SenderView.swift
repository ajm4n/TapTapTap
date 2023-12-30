//
//  SenderView.swift
//  watchSendTap
//
//  Created by ajman on 12/12/23.
//

import SwiftUI

struct SenderView: View {
    @ObservedObject var pairingManager: PairingManager

    var body: some View {
        VStack {
            Text("Send Vibration")
                .font(.title)
                .padding()

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
                    // Display an error message
                    print("Please pair with another device first.")
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
        }
        .padding()
        .navigationTitle("Sender")
    }
}
