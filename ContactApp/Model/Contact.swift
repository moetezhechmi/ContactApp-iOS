
import CoreData

@objc(Person)
class Person: NSManagedObject
{
    @NSManaged var id: NSNumber!
    @NSManaged var name: String!
    @NSManaged var surName: String!
    @NSManaged var photoURL: String!
    @NSManaged var phoneNumber: [String]
}
