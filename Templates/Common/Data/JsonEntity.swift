//
//  JsonEntity.swift
//  Templates
//
//  Created by user on 12/11/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

typealias JsonSerializationError = Error

public enum JsonEntityType {
    case array([JsonEntity])
    case dictionary([String: JsonEntity])
    case int32(Int32)
    case int64(Int64)
    case float(Float)
    case double(Double)
    case string(String)
    case bool(Bool)
    case number(NSNumber)
    case null
    
}

public protocol JsonEntity {
    
    func type() -> JsonEntityType
    
}

extension JsonEntity {
    
    func array() -> [JsonEntity] {
        switch self.type() {
        case .array(let val):
            return val
        default:
            return []
        }
    }
    
    func dictionary() -> [String: JsonEntity] {
        switch self.type() {
        case .dictionary(let val):
            return val
        default:
            return [:]
        }
    }
    
    func int32(def: Int32 = 0) -> Int32 {
        switch self.type() {
        case .int32(let val):
            return val
        case .int64(let val):
            return Int32(val)
        case .float(let val):
            return Int32(val)
        case .double(let val):
            return Int32(val)
        case .string(let val):
            return Int32(val) ?? def
        case .number(let val):
            return val.int32Value
        default:
            return def
        }
    }
    
    func int64(def: Int64 = 0) -> Int64 {
        switch self.type() {
        case .int64(let val):
            return val
        case .int32(let val):
            return Int64(val)
        case .float(let val):
            return Int64(val)
        case .double(let val):
            return Int64(val)
        case .string(let val):
            return Int64(val) ?? def
        case .number(let val):
            return val.int64Value
        default:
            return def
        }
    }
    
    func float(def: Float = 0.0) -> Float {
        switch self.type() {
        case .float(let val):
            return val
        case .int32(let val):
            return Float(val)
        case .int64(let val):
            return Float(val)
        case .double(let val):
            return Float(val)
        case .string(let val):
            return Float(val) ?? def
        case .number(let val):
            return val.floatValue
        default:
            return def
        }
    }
    
    func double(def: Double = 0.0) -> Double {
        switch self.type() {
        case .double(let val):
            return val
        case .int32(let val):
            return Double(val)
        case .int64(let val):
            return Double(val)
        case .float(let val):
            return Double(val)
        case .string(let val):
            return Double(val) ?? def
        case .number(let val):
            return val.doubleValue
        default:
            return def
        }
    }
    
    func string(def: String? = nil) -> String? {
        switch self.type() {
        case .string(let val):
            return val
        case .int32(let val):
            return String(val)
        case .int64(let val):
            return String(val)
        case .float(let val):
            return String(val)
        case .double(let val):
            return String(val)
        case .number(let val):
            return val.stringValue
        default:
            return def
        }
    }
    
    func bool(def: Bool = false) -> Bool {
        switch self.type() {
        case .bool(let val):
            return val
        case .int32(let val):
            return val != 0
        case .int64(let val):
            return val != 0
        case .float(let val):
            return val != 0.0
        case .double(let val):
            return val != 0.0
        case .string(let val):
            switch val.lowercased() {
            case "", "0", "false":
                return false
            default:
                return true
            }
        case .number(let val):
            return val.boolValue
        default:
            return def
        }
    }
    
    func isNull() -> Bool {
        switch self.type() {
        case .null:
            return true
        default:
            return false
        }
    }
    
    func isArray() -> Bool {
        switch self.type() {
        case .array(_):
            return true
        default:
            return false
        }
    }
    
    func isDictionary() -> Bool {
        switch self.type() {
        case .dictionary(_):
            return true
        default:
            return false
        }
    }
    
    func uuid() -> UUID? {
        switch self.type() {
        case .string(let string):
            switch string.count {
            case 36:
                return UUID(uuidString: string)
            case 32:
                let range1 = Range(uncheckedBounds: (string.startIndex, string.index(string.startIndex, offsetBy: 8)))
                let range2 = Range(uncheckedBounds: (string.index(string.startIndex, offsetBy: 9), string.index(string.startIndex, offsetBy: 13)))
                let range3 = Range(uncheckedBounds: (string.index(string.startIndex, offsetBy: 14), string.index(string.startIndex, offsetBy: 18)))
                let range4 = Range(uncheckedBounds: (string.index(string.startIndex, offsetBy: 19), string.index(string.startIndex, offsetBy: 23)))
                let range5 = Range(uncheckedBounds: (string.index(string.startIndex, offsetBy: 24), string.endIndex))
                return UUID(uuidString: "\(string[range1])-\(string[range2])-\(string[range3])-\(string[range4])-\(string[range5])")
            default:
                return nil
            }
        default:
            return nil
        }
    }
    
    func isNumber() -> Bool {
        switch self.type() {
        case .int32(_), .int64(_), .double(_), .float(_), .number(_), .bool(_):
            return true
        default:
            return false
        }
    }
    
    func isString() -> Bool {
        switch self.type() {
        case .string(_):
            return true
        default:
            return false
        }
    }
    
    subscript(index: Int) -> JsonEntity {
        get {
            switch self.type() {
            case .array(let val):
                return val[index]
            default:
                fatalError()
            }
        }
    }
    
    subscript(key: String) -> JsonEntity? {
        get {
            switch self.type() {
            case .dictionary(let val):
                return val[key]
            default:
                fatalError()
            }
        }
    }
    
    func missingKeys<C: Collection>(_ keys: C) -> Set<C.Element> where C.Element == String {
        switch self.type() {
        case .dictionary(let val):
            var result = Set<C.Element>()
            keys.forEach { (key) in
                if !val.keys.contains(key) {
                    result.insert(key)
                }
            }
            return result
        default:
            fatalError()
        }
    }
}

extension Array: JsonEntity where Element == JsonEntity {
    
    public func type() -> JsonEntityType {
        return .array(self)
    }
    
}

extension Dictionary: JsonEntity where Key == String, Value == JsonEntity {
    
    public func type() -> JsonEntityType {
        return .dictionary(self)
    }
    
}

extension NSArray: JsonEntity {
    
    public func type() -> JsonEntityType {
        return .array(self as! [JsonEntity])
    }
    
}

extension NSDictionary: JsonEntity {
    
    public func type() -> JsonEntityType {
        return .dictionary(self as! [String : JsonEntity])
    }
    
}

extension Int: JsonEntity {
  
    public func type() -> JsonEntityType {
#warning("Make sure it's the case")
        return .int64(Int64(self))
    }
}

extension Int32: JsonEntity {
    public func type() -> JsonEntityType {
        return .int32(self)
    }
}

extension Int64: JsonEntity {
    public func type() -> JsonEntityType {
        return .int64(self)
    }
}

extension Float: JsonEntity {
    public func type() -> JsonEntityType {
        return .float(self)
    }
}

extension Double: JsonEntity {
    public func type() -> JsonEntityType {
        return .double(self)
    }
}

extension String: JsonEntity {
    public func type() -> JsonEntityType {
        return .string(self)
    }
}

extension NSString: JsonEntity {
    public func type() -> JsonEntityType {
        return .string(self as String)
    }
}

extension NSNumber: JsonEntity {
    public func type() -> JsonEntityType {
        return .number(self as NSNumber)
    }
}

extension Bool: JsonEntity {
    public func type() -> JsonEntityType {
        return .bool(self)
    }
}


extension NSNull: JsonEntity {
    public func type() -> JsonEntityType {
        return .null
    }
}

enum ToJsonSerializationError: Error {
    case emptyData
    case serilization(Error)
}

extension JSONSerialization {
    
    static func jsonEntity(string: String) throws -> JsonEntity {
        return try jsonEntity(data: string.data(using: .utf8))
    }
    
    static func jsonEntity(data: Data?) throws -> JsonEntity {
        guard let data = data else {
            throw ToJsonSerializationError.emptyData
        }
        do {
            if let json = try jsonObject(with: data, options: []) as? JsonEntity {
                return json
            } else {
                throw ToJsonSerializationError.emptyData
            }
        } catch let e {
            throw ToJsonSerializationError.serilization(e)
        }
    }
    
}
