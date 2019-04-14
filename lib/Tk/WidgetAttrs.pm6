role Tk::TextAttrs is export {
	my Int $text-var = 0;
	has Str $.text-var = "txtvar{$text-var++}";

	multi method text {
		%.options<text>;
	}

	multi method text(Str $value is copy) {
		$value .= subst(/('{' | '}')/, '\$0', :g);
		%.options<text> = $value;
		self.get-root.raw("set $!text-var \{$value\}");
	}

	# state, font, justify, underline, wraplength
}

role Tk::ColorAttrs is export {
	multi method fg {
		%.options<fg> orelse "black"
	}

	multi method fg(Str $color is copy) {
		$color = "\{$color\}" if $color.words > 1;
		%.options<fg> = $color;
		self.get-root.raw("$.path configure -fg \"$color\"")
	}

	multi method bg {
		%.options<bg> orelse "white"
	}

	multi method bg(Str $color is copy) {
		$color = "\{$color\}" if $color.words > 1;
		$.options<bg> = $color;
		self.get-root.raw("$.path configure -bg \"$color\"")
	}

	# relief

	multi method borderwidth {
		%.options<borderwidth> orelse 0
	}

	multi method borderwidth(Int $bd) {
		%.options<borderwidth> = $bd;
		self.get-root.raw("$.path configure -bd $bd")
	}
}

role Tk::ScalableAttrs is export {
	multi method width {
		%.options<width> orelse 0
	}

	multi method width(Int $value) {
		%.options<width> = $value;
		self.get-root.raw("$.path configure -width $value")
	}

	multi method height {
		%.options<height> orelse 0
	}

	multi method height(Int $value) {
		%.options<height> = $value;
		self.get-root.raw("$.path configure -height $value")
	}

	multi method padx {
		%.options<padx> orelse 0
	}

	multi method padx(Int $value) {
		%.options<padx> = $value;
		self.get-root.raw("$.path configure -padx $value")
	}

	multi method pady {
		%.options<pady> orelse 0
	}

	multi method pady(Int $value) {
		%.options<pady> = $value;
		self.get-root.raw("$.path configure -pady $value")
	}
}
