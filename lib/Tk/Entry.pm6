use Tcl;
use Tk::Widget;
use Tk::WidgetAttrs;
use Tk::Root;

class Tk::Entry does Tk::Widget does Tk::TextAttrs does Tk::ColorAttrs is export {
	has Str $!txt = "";

	method new(*%options) {
		self.bless:
			:%options
	}

	multi method text {
		$!txt
	}

	multi method text(Str $value is copy) {
		$value .= subst(/('{' | '}')/, '\$0', :g);
		$!txt = $value;
		self.get-root.raw("set $!text-var \{$value\}");
	}

	method compile {
		"entry $!path -textvariable $!text-var {%!options.kv.map: -> $k, $v {"-$k \"$v\""}}"
	}
}
