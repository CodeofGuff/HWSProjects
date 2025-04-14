import Cocoa

struct Employee {
	let name: String
	var vacayAllocated = 14
	var vacayTaken = 0
	var vacayRemaining: Int {
		get {
			vacayAllocated - vacayTaken
		}
		set {
			vacayAllocated = vacayTaken + newValue
		}
	}
}

var archer = Employee(name: "Sterling Archer", vacayAllocated: 10)
archer.vacayTaken += 4
archer.vacayRemaining = 5
print(archer.vacayAllocated)
