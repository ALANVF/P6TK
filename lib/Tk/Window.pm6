use Tcl;
use Tk::Widget;

class Tk::Window does Tk::Widget is export {
	has $.root is rw;

	method new(*%options) {
		%options<width> = 0;
		%options<height> = 0;

		self.bless:
			:%options
	}

	multi method geometry {
		<width height> Z %.options<width height>
	}

	# add offsets later
	multi method geometry(Int $w where * ≥ 0, Int $h where * ≥ 0) {
		%.options<width> = $w;
		%.options<height> = $h;

		$!root.raw("wm geometry . {$w}x{$h}")
	}

	method get-root {
		self.root
	}
}
