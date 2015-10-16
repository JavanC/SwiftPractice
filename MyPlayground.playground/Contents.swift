import Cocoa

class Person {
    
    var FirstName = ""
    var LastName = ""
    var age = 0
    
    func input() -> String {
        let keyboard = NSFileHandle.fileHandleWithStandardInput()
        let inputData = keyboard.availableData
        let rawString = NSString(data: inputData, encoding:NSUTF8StringEncoding)
        if let string = rawString {
            return string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        } else {
            return "Invalid input"
        }
    }
    
    func changeFirstName(newFirstName: String) {
        FirstName = newFirstName
    }
    
    func enterInfo() {
        print("What is the name?")
        FirstName = input()
    }
    
    func printInfo() {
        print("First Name: \(FirstName)")
    }
    
}

var newPerson = Person()
newPerson.FirstName = "Chen"
newPerson.LastName = "Javan"
newPerson.age = 17

newPerson.changeFirstName("Paul")

