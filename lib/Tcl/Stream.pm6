class Tcl::Stream is export {
    has Proc::Async $.proc;

    method new {
        self.bless:
                :proc(Proc::Async.new(:w, <wish>))
    }

    method start {
        $!proc.start
    }

    method close {
        $!proc.close-stdin
    }

    method kill {
        $!proc.kill
    }

    method get(&out:($), &err:($)) {
        $!proc.stdout.tap(-> $v {
            start {
                out $v
            }
        }, quit => &err)
    }

    method error(&err:($)) {
        $!proc.stderr.tap(&err)
    }

    method send(Str $cmd) {
        $!proc.say: $cmd
    }
}