//
//  Closures.swift
//  MusicSearch
//
//  Created by Vinsi on 29/03/2022.
//

typealias GenericInClosure<T> = ((T) -> ())
typealias GenericInOutClosure<T, O> = ((T) -> O)
typealias GenericOutClosure<T> = (() -> T)
typealias EmptyClosure = (() -> ())
