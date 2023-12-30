//
//  PairingView.swift
//  watchSendTap
//
//  Created by ajman on 12/12/23.
//

import SwiftUI

struct PairingFormView: View {
    @Binding var username: String
    @ObservedObject var pairingManager: PairingManager

    var body: some View {
        VStack {
            // ... other pairing form fields ...
            TextField("Enter username", text: $username)
                .padding()

            Button("Pair") {
                pairingManager.pairWithUser(username: username, pairingCode: "123456") { success in
                    if success {
                        // Handle successful pairing, if needed
                    } else {
                        // Handle failed pairing, if needed
                    }
                }
            }
            .padding()
        }
        .padding()
    }
}

struct PairingFormView_Previews: PreviewProvider {
    static var previews: some View {
        PairingFormView(username: .constant("John"), pairingManager: PairingManager())
    }
}

