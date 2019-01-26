//
//  TrainerServices.swift
//
//  Created by Waleed on 1/22/19.
//  Copyright © 2019 Waleed Sarwari. All rights reserved.
//

// USE AS IS
// THIS SAVE DICTIONARY VALUES TO GOOGLE FIREBASE DATABASE. 
// THIS ASSUMES ALL THE GOOGLE DATABASE SETUP IS ALREADY DONE. 

import Foundation

final class TrainerServices {
    
    // MARK: - Properties
    
    static let shared: TrainerServices = TrainerServices()
    
    private init() { }
    
    // Save sports values
    func saveSportsValues(sports: Array<String>) {
        // Update db with new value
        let newValue = [
            Trainer.UserInfoKey.sports : sports
            ] as [String : Any]
        
        TRAINER_DB_REF.child(Utilities.getCurrentUserId()).updateChildValues(newValue)

    }
    
    func getSportsValues(completionHandler: @escaping(Array<String>) -> Void) {
        TRAINER_DB_REF.child(Utilities.getCurrentUserId()).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var sportsValues: Array<String>
            
            // Get user value
            let value = snapshot.value as? NSDictionary
            sportsValues = value?[Trainer.UserInfoKey.sports] as? Array<String> ?? [""]
            
            completionHandler(sportsValues)
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
