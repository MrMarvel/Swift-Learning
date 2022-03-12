import Foundation
import os
class Owner {
    weak var member: Member?
    
    init() {
        print("\(self) : \(#function)")
    }
    
//    func isMemberActivated(_ x: Float) -> Bool? {
//        let res: Bool? = member?.functionActivation?(x)
//        print("\(self) : \(#function): \(String(describing: res))")
//        return res
//    }
    
    func eventListener() {
        print("\(self) : \(#function)")
    }
    
    deinit{
        print("\(self) : \(#function)")
    }
}

class Member {
    weak var owner: Owner?
    
    init() {
        print("\(self) : \(#function)")
    }
    
    var functionActivation: ((Float) -> Bool)?
    
//    func F(_ x: Float) -> Bool {
//        return functionActivation(x)
//    }
    
    func dispatchEvent(_ x: Float) {
        print("\(self) : \(#function)[\(x)]")
        functionActivation?(x)
    }
    
    deinit{
        print("\(self) : \(#function)")
    }
}

var owner: Owner? = Owner()
var member: Member? = Member()

owner?.member = member
member?.owner = owner
member?.functionActivation = {[owner] x -> Bool in
    var res = false
    if (x > 0) {
        res = ((owner?.eventListener()) != nil)
    }
//    print("\(#function) : CLOSURE : \(String(describing: res))")
    return res
}
member?.dispatchEvent(5)

owner = nil
member?.dispatchEvent(3)
member = nil

