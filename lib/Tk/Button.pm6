use Tcl;
use Tk::Widget;
use Tk::WidgetAttrs;
use Tk::Root;

class Tk::Button does Tk::Widget does Tk::TextAttrs does Tk::ColorAttrs does Tk::ScalableAttrs is export {
	method new(*%options) {
		%options<text> ||= "";
		self.bless:
			:%options,
	}

	method pressed(&body) {
		%!options<command> = "puts stdout \\\"$!path <<Invoke>> w \%w\\\"";
		%!events{"<<Invoke>>"} = &body
	}

	method compile {
		"button $!path {%!options.kv.map: -> $k, $v {"-$k \"$v\""}}"
	}
}