//
//  Feelings.swift
//  Xpresso
//
//  Created by Bharam,Kamala Priya on 4/15/17.
//  Copyright © 2017 Bharam,Kamala Priya. All rights reserved.
//

import Foundation
import Parse
import Bolts

class Feelings:PFObject,PFSubclassing {
    
    @NSManaged var story: String
    
    @NSManaged var heading: String

    static func parseClassName() -> String {
        
        return "feelings"
    
    
}

}

