use Tcl;
use Tk::Window;

class Tk::Root is export {
	has Tcl::Interp $.interp;
	has Tk::Window $.win;

	method new {
		self.bless:
			interp => Tcl::Interp.new,
			win => Tk::Window.new
	}

	submethod BUILD(:$!interp, :$win) {
		$!win = $win;
		$!win.root = self;
	}

	submethod AT-KEY(Str $key) {
		$!win{$key}
	}

	submethod ASSIGN-KEY(Str $key, Tk::Widget \val) {
		$!win{$key} = val
	}

	method get-path(Str $path) {
		my @path = $path.split(".").Array;
		@path .= rotate.pop;

		my $r := $!win;

		for @path -> $k {
			$r := $r{$k}
		}

		$r
	}

	multi method raw(Str $cmd) {
		$!interp.send: $cmd
	}

	multi method raw(*@cmd) {
		$!interp.send: @cmd.join(" ")
	}

	# TODO: add io with $!interp

	method main(&b) {
		$!interp.out(-> $v {
			my ($path, $event, $rest) = $v.trim.split(" ", 3);

			$rest = Tcl::OptionParser::Parser.new.parse($rest);

			if self.get-path($path).events{$event}:exists {
				self.get-path($path).events{$event}($rest)
			}
		});

		$!interp.init(&b)
	}

	method quit {
		$!interp.send: "exit"
	}
}
