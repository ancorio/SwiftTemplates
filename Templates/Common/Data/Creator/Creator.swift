//
//  Creator.swift
//  Templates
//
//  Created by user on 12/16/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit


public class Creator<ObjectType> {

    public func create() -> ObjectType {
        fatalError("Must be overriden.")
    }
    
}

public class ArrayCreator<ObjectType>: Creator<[ObjectType]> {

    override public func create() -> [ObjectType] {
        return [ObjectType]()
    }
    
}
