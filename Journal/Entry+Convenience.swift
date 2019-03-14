//
//  Entry+Convenience.swift
//  Journal
//
//  Created by Alex Lundquist on 3/14/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    
    @discardableResult //Maybe I am going to use the return value.. maybe you won't.. so CoreData is going ot hold it under the hood
    //Technically these are not Properties of the model you could type titleParameter, textParameter, etc...Like we just did to show a point
   convenience init(titleParameter: String, textParameter: String, timestampParameter: Date = Date(), managedObjectContextParameter: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: managedObjectContextParameter)
        self.title = titleParameter
        self.text = textParameter
        self.timestamp = timestampParameter
    }
}
