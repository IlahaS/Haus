//
//  UserStateObserver.swift
//  Haus
//
//  Created by Ilahe Samedova on 13.04.24.
//

import Foundation

protocol UserStateObservable: AnyObject {
    func didLogin()
    func didLogout()
}


class UserStateObserver {
    static let shared = UserStateObserver()
    private var observers = NSHashTable<AnyObject>.weakObjects()

    private init() {}

    func addObserver(_ observer: UserStateObservable) {
        observers.add(observer)
    }

    func removeObserver(_ observer: UserStateObservable) {
        observers.remove(observer)
    }

    func notifyLoginObservers() {
        for observer in observers.allObjects {
            (observer as? UserStateObservable)?.didLogin()
        }
    }

    func notifyLogoutObservers() {
        for observer in observers.allObjects {
            (observer as? UserStateObservable)?.didLogout()
        }
    }
}

