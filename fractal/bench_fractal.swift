
let BAILOUT = 16.0;
let MAX_ITERATIONS = 1000;

class Mandelbrot {

	init() {
		print("Rendering")
		for y in -39...39 {
			print("")
			for x in -39...39 {
				let i = iterate(Double(x) / 40.0, y: Double(y) / 40.0);
				if (i == 0) {
					out("*")
				} else {
					out(" ")
				}
			}
		}
		print("")
	}

	func iterate(x: Double, y: Double) -> Int {
		let cr = y - 0.5
		let ci = x
		var zi = 0.0
		var zr = 0.0
		var i = 0

		while (true) {
			i += 1
			let temp = zr * zi
			let zr2 = zr * zr
			let zi2 = zi * zi
			zr = zr2 - zi2 + cr
			zi = temp + temp + ci
			if (zi2 + zr2 > BAILOUT) { return i }
			if (i > MAX_ITERATIONS) { return 0 }
		}

	}

	func out(s: String) {
		print(s, terminator: "")
	}

}

Mandelbrot()
