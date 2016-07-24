//
//  Shims.swift
//  Chameleon
//
//  Created by Ian Keen on 21/07/2016.
//
//

import Vapor
import Engine

public typealias JSONRepresentable = Vapor.JSONRepresentable
public typealias JSON = Vapor.JSON
public typealias Headers = Vapor.Headers
public typealias HTTPResponse = Engine.HTTPResponse

import Foundation
public typealias Date = NSDate
public typealias URL = NSURL

#if os(Linux)
    public typealias TimeInterval = NSTimeInterval
    public typealias ProcessInfo = NSProcessInfo
#endif
