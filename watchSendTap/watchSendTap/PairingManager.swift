//
//  PairingManager.swift
//  watchSendTap
//
//  Created by ajman on 12/12/23.
//

import CloudKit

class PairingManager: ObservableObject {
    @Published var pairingCode: String? = nil
    @Published var pairedUser: CKRecord?

    func generatePairingCode() {
        pairingCode = PairingCodeGenerator.generateCode()
    }

    func pairWithUser(username: String, pairingCode: String, completion: @escaping (Bool) -> Void) {
        // Validate the pairing code and retrieve the paired user record from CloudKit
        verifyPairingCode(pairingCode) { [weak self] success in
            guard success else {
                completion(false)
                return
            }

            // Save the pairing configuration
            self?.saveUserRecord(username: username, pairingCode: pairingCode)

            // Fetch the paired user record
            self?.fetchUserRecord(withUsername: username) { userRecord in
                if let userRecord = userRecord {
                    self?.pairedUser = userRecord
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }

    func saveUserRecord(username: String, pairingCode: String) {
        let userRecord = CKRecord(recordType: "User")
        userRecord["Username"] = username
        userRecord["PairingCode"] = pairingCode

        let database = CKContainer(identifier: "iCloud.ajman.watchSendTap").publicCloudDatabase

        database.save(userRecord) { (_, error) in
            if let error = error {
                print("Error saving user record: \(error)")
            } else {
                print("User record saved successfully.")
            }
        }
    }

    func fetchUserRecord(withUsername username: String, completion: @escaping (CKRecord?) -> Void) {
        let predicate = NSPredicate(format: "Username == %@", username)
        let query = CKQuery(recordType: "User", predicate: predicate)

        let database = CKContainer(identifier: "iCloud.ajman.watchSendTap").publicCloudDatabase

        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching user record: \(error)")
                completion(nil)
            } else {
                completion(records?.first)
            }
        }
    }
}
