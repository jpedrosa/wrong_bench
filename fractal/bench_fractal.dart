import "dart:io";

const BAILOUT = 16;
const MAX_ITERATIONS = 1000;

class Mandelbrot {

	Mandelbrot() {
		print("Rendering");
		for (var y = -39; y <= 39; y++) {
			print("");
			for (var x = -39; x <= 39; x++) {
				var i = iterate(x / 40.0, y / 40.0);
				if (i == 0) {
					out("*");
				} else {
					out(" ");
				}
			}
		}
		print("");
	}

	iterate(x, y) {
		var cr = y - 0.5, ci = x, zi = 0.0,	zr = 0.0, i = 0;

		while (true) {
			i += 1;
			var temp = zr * zi;
			var zr2 = zr * zr;
			var zi2 = zi * zi;
			zr = zr2 - zi2 + cr;
			zi = temp + temp + ci;
			if (zi2 + zr2 > BAILOUT) { return i; }
			if (i > MAX_ITERATIONS) { return 0; }
		}

	}

	out(s) {
		stdout.write(s);
	}

}

main() {
	new Mandelbrot();
}
