use Tcl;

role Tk::Widget is export {
	has Tk::Widget %.table;
	has %.options is rw;
	has %.events is rw;

	has Str $.name is rw = "";
	has Str $.path is rw = "";
	has Tk::Widget $.parent is rw;

	# $root<widget>
	submethod AT-KEY(Str $key) {
		return %!table{$key}
	}

	# $root<widget> = ...
	submethod ASSIGN-KEY(Str $key, Tk::Widget \val) {
		val.name = $key;
		val.parent = self;
		val.path = $!path ~ "." ~ val.name;
		%!table{$key} = val
	}

	method init(Tk::Widget \parent) {
		$!path = parent.path ~ "." ~ $!name;
		$!parent = parent;
	}

	method pack(*%options) {
		self.get-root.raw("pack [{self.compile}] {%options.kv.map('-'~*~' "'~*~'"')}");
	}

	method bind(Str $event, &body) {
		self.get-root.raw(
			"bind $!path $event \{
				set data [list {'a %a b %b c %c d %d f %f h %h i %i k %k m %m o %o p %p s %s t %t w %w x %x y %y A %A B %B D %D E %E K %K M %M N %N P %P R %R S %S T %T W %W X %X Y %Y'}]

				foreach \{k v\} \$data \{
					if \{\$v eq \"??\"\} \{
						dict unset data \$k
					\}
				\}

				puts stdout \"$!path $event \$data\"\
			\}"
			);
		%!events{$event} = &body
	}

	method get-root {
		self.parent.get-root
	}
}
