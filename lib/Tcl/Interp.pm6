use Tcl::Stream;

class Tcl::Interp is export {
	has Tcl::Stream $.io;
	has &.stdout is rw;
	has &.exception is rw;
	has &.stderr is rw;

	method new {
		self.bless:
			:io(Tcl::Stream.new),
			:stdout(-> $v {}),
			:exception(-> $v {}),
			:stderr(-> $v {})
	}

	method out(&o:($)) {
		&!stdout = &o
	}

	method exception(&e:($)) {
		&!exception = &e
	}

	method err(&e:($)) {
		&!stderr = &e
	}

	method send(Str $cmd) {
		$!io.send: $cmd
	}

	method init(&body) {
		$!io.get(&!stdout, &!exception);
		$!io.error(&!stderr);
		my $promise = $!io.start;

		await start {
			body
		}

		await $promise;
		$!io.kill
	}

	method quit {
		$!io.kill
	}
}