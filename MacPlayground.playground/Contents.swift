import Cocoa




func sumOfPositives (_ numbers: [Int] ) -> Int {
	var total  = 0
	for i in numbers {
		if i > 0 {
			total += i
		}
		print(total)
	}
	return total
}

sumOfPositives( [1, 2, 3, 4, 5, -8, -10] )
