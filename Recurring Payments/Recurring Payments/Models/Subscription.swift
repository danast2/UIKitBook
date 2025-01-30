
import Foundation

struct Subscription: Codable {
    let id: UUID
    let name: String
    let price: Double
    let renewalDate: Date
    let cycle: BillingCycle
    let paymentMethod: String
}
