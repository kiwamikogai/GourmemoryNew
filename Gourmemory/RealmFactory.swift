import RealmSwift

class RealmFactory {
    
    // MARK: - Properties
    static let sharedInstance = RealmFactory()
    internal var configuration: Realm.Configuration?
    
    private init() {
    }
    
    
    
    // MARK: - Publics
    internal func realm() -> Realm {
        if let configuration = configuration {
            return try! Realm(configuration: configuration)
        } else {
            return try! Realm()
        }
    }
}
