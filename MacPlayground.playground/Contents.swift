import Cocoa





class Vehicle {
	let isElectric: Bool
	
	init(isElectric: Bool) {
		self.isElectric = isElectric
	}
}

class Car: Vehicle {
	let isConvertable = false
	
}
let honda = Car(isElectric: false)
