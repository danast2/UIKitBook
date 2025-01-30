//
//  AddSubscriptionDelegate.swift
//  Recurring Payments
//
//  Created by Даниил Асташов on 30.01.2025.
//

import Foundation

protocol AddSubscriptionDelegate: AnyObject{
    func didAddSubscription(_ subscription: Subscription)
}
