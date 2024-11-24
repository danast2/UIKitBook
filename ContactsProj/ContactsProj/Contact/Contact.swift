//
//  Contact.swift
//  ContactsProj
//
//  Created by Даниил Асташов on 25.11.2024.
//

import Foundation

protocol ContactProtocol {
 /// Имя
 var title: String { get set }
 /// Номер телефона
 var phone: String { get set }
}
struct Contact: ContactProtocol {
 var title: String
 var phone: String
}
