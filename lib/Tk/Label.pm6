use Tcl;
use Tk::Widget;
use Tk::WidgetAttrs;
use Tk::Root;

class Tk::Label does Tk::Widget does Tk::TextAttrs does Tk::ColorAttrs is export {
    method new(*%options) {
        %options<text> ||= "";
        self.bless:
			:%options
    }

    method compile {
        "label $!path -textvariable $!text-var {%!options.kv.map: -> $k, $v {"-$k \"$v\""}}"
    }
}