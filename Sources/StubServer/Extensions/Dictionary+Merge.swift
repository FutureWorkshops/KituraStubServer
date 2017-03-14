//
//  Dictionary+Merge.swift
//  StubServer
//

import Foundation

extension Dictionary {
    mutating func union(dictionary: Dictionary<Key, Value>) {
        for (key, value) in dictionary { self[key] = value }
    }

    mutating func union<S: Sequence>(sequence: S) where S.Iterator.Element == (Key,Value) {
        for (key, value) in sequence { self[key] = value }
    }
}
