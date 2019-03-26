use Tcl;
use Tk::Widget;
use Tk::WidgetAttrs;
use Tk::Root;

class Tk::Frame does Tk::Widget does Tk::ColorAttrs does Tk::ScalableAttrs is export {
	method new(*%options) {
		self.bless:
			:%options
	}

	method compile {
		"frame $!path {%!options.kv.map: -> $k, $v {"-$k \"$v\""}}"
	}
}