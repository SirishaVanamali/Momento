//
//  EntryModel.swift
//  Xpresso
//
//  Created by Vanamali,Sirisha on 4/13/17.
//  Copyright © 2017 Bharam,Kamala Priya. All rights reserved.
//

import UIKit

class EntryModel: NSObject {

    
    var feelings:String = "Nothing"
   
    
    func pickerView() -> String{ //return a string with the current order
        return feelings + " Todays Feeling "
    }
    
    
    
}
