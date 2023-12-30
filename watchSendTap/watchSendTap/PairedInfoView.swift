//
//  PairedInfoView.swift
//  watchSendTap
//
//  Created by ajman on 12/13/23.
//

import Foundation
import SwiftUI
import CloudKit

struct PairedInfoView: View {
    let pairedUser: CKRecord

    var body: some View {
        VStack {
            Text("Paired with:")
            Text("Username: \(pairedUser["Username"] as? String ?? "N/A")")
            Text("Pairing Code: \(pairedUser["PairingCode"] as? String ?? "N/A")")
            // ... other paired information ...
        }
        .padding()
    }
}

struct PairedInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PairedInfoView(pairedUser: CKRecord(recordType: "User"))
    }
}
