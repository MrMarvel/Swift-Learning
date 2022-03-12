import Foundation
import Security

public protocol CarProducer: AnyObject {
    func buildCar(_ car: String) -> Car?
}

public final class CarFactory {
    private static var idIterator: Int = 0
    let id: Int
    var carAmount: Int = 0
    
    public init() {
        CarFactory.idIterator += 1
        id = CarFactory.idIterator
    }
    
    public enum CarName : String {
        case V1
        case V2
        case V3
    }
}

extension CarFactory: CarProducer {
    public func buildCar(_ car: String) -> Car? {
        guard let carN: CarName = CarName(rawValue:car)
        else {
            return nil
        }
        carAmount+=1
        switch (carN) {
        case CarName.V1:
            return V1(byFactory: id)
        case CarName.V2:
            return V2(byFactory: id)
        case CarName.V3:
            return V3(byFactory: id)
        }
    }
}

public struct Engine {
    var fuel: Fuel = Fuel.BENSIN
    var desc: String = ""
    
    public enum Fuel: String {
        case DISEL
        case BENSIN
        case KEROSIN
        case OIL
    }
}

public struct Tire {
    var sise: Int = 0
}

public struct Wheel {
    var maxAngle: Int = 270
}

public protocol Car {
    
    var isEngineOn: Bool { get set}
    var engine: Engine? {get set}
    var wheel: Wheel {get set}
    var tires: [Tire] {get set}
    var desc: String {get set}
    var byFactory: Int {get set}
    
    init(byFactory: Int)
    
    mutating func engineOn()
    mutating func engineOff() // TABLE диспетчеризация
    mutating func replaceEngine(with engine: Engine)
    mutating func replaceTires(with tires: [Tire])
    
}

extension Car {
    
    mutating func replaceEngine(with engine: Engine) {
        self.engine = engine
        print("replaced engine with " + engine.fuel.rawValue + " & "+engine.desc)
    }
    mutating func engineOn() {
        isEngineOn = true
        print("default ENGINE ON")
    }
    
    mutating func engineOff() {
        isEngineOn = false
        print("default ENGINE OFF")
    }
    
    mutating func replaceTires(with tires: [Tire]) {
        self.tires = tires
        print("\(self):\(#function)")
    }
}



struct V1: Car {
    var wheel: Wheel
    
    var tires: [Tire]
    
    var isEngineOn: Bool
    
    var engine: Engine?
    
    var desc: String
    
    var byFactory: Int
    
    var unique1 = 1
    
    init(byFactory: Int) {
        self.byFactory = byFactory
        self.isEngineOn = false
        self.desc = ""
        self.engine = Engine(fuel: Engine.Fuel.BENSIN)
        self.tires = [.init(), .init(sise: 34), .init()]
        self.wheel = Wheel(maxAngle: 360)
    }
    
    func engineOn() { // TABLE диспетчеризация
        print("V1 ON")
    }
    
    func controlRoof(newState: Bool) { // DIRECT/STATIC диспетчеризация
        //
    }
}

struct V2: Car {
    var wheel: Wheel
    
    var tires: [Tire]
    
    var isEngineOn: Bool
    
    var engine: Engine?
    
    var desc: String
    
    var byFactory: Int
    
    var unique2 = 2
    
    init(byFactory: Int) {
        self.byFactory = byFactory
        self.isEngineOn = false
        self.desc = ""
        self.engine = Engine(fuel: Engine.Fuel.OIL)
        self.tires = [.init(), .init(sise: 32), .init()]
        self.wheel = .init()
    }
    func engineOn() {
        print("V2 ON")
    }
}

struct V3: Car {
    var wheel: Wheel
    
    var tires: [Tire]
    
    var isEngineOn: Bool
    
    var engine: Engine?
    
    var desc: String
    
    var byFactory: Int
    
    var unique3 = 3
    
    init(byFactory: Int) {
        self.byFactory = byFactory
        self.isEngineOn = false
        self.desc = ""
        self.engine = Engine(fuel: Engine.Fuel.DISEL)
        self.tires = [.init(), .init(sise: 31), .init()]
        self.wheel = .init()
    }
    func engineOn() {
        print("V3 ON")
    }
}

public class WeakRef<T> where T: AnyObject {

    private(set) weak var value: T?

    init(value: T?) {
        self.value = value
    }
}

class Dealer {
//    var importer: [WeakRef<CarProducer>]
    weak var importer: CarProducer?
    func saleCar(_ type: CarFactory.CarName) -> Car? {
        importer?.buildCar(type.rawValue)
    }
}

let factory = CarFactory()
let dealer = Dealer()
dealer.importer = factory
var car: Car?
car = dealer.saleCar(CarFactory.CarName.V1)
car?.engineOn()
car?.replaceEngine(with: Engine(fuel: Engine.Fuel.BENSIN, desc: "LOL"))
var v1: V1? = car as? V1 ?? nil
print(v1?.unique1 ?? "Hueston we have a problem")
