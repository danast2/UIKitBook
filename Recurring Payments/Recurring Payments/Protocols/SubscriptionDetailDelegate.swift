//
//  SubscriptionDetailDelegate.swift
//  Recurring Payments
//
//  Created by Даниил Асташов on 31.01.2025.
//

import Foundation

protocol SubscriptionDetailDelegate: AnyObject{
    func didDeleteSubscription(_ subscriptionID: UUID)
    func didUpdateSubscription(_ subscription: Subscription)
}
