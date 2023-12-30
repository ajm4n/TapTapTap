//
//  RecieverView.swift
//  watchSendTap
//
//  Created by ajman on 12/12/23.
//
import SwiftUI

struct ReceiverView: View {
    @ObservedObject var pairingManager: PairingManager

    @State private var selectedDevice: String?

    var body: some View {
        VStack {
            Text("Receive Vibration")
                .font(.title)
                .padding()

            if let selectedDevice = selectedDevice {
                Text("Paired Device: \(selectedDevice)")
                    .font(.headline)
                    .padding()
            }

            Picker("Select Paired Device", selection: $selectedDevice) {
                ForEach(pairingManager.pairedDevices, id: \.self) { deviceID in
                    Text(deviceID)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()

            Button(action: {
                if let selectedDevice = selectedDevice {
                    // Connect to the selected paired device
                    print("Connecting to device with ID: \(selectedDevice)")
                } else {
                    print("No device selected.")
                }
            }) {
                Text("Connect to Device")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.bottom, 10)
            }
        }
        .padding()
        .navigationTitle("Receiver")
    }
}
