grammar Tcl::OptionParser-Grammar {
    rule TOP {<option>* %% \s+}
    #
    token name  {<.alpha>\w*}
    token lts {'{' (<-[\{\}]> || <.lts>) '}'}
    token value {<lts> | \S+}
    #
    token option {<name> \h <value>}
}

class Tcl::OptionParser-Actions {
    method TOP($/) {
        make ($<option>».made)
    }

    method option($/) {
        make ($<name>.made => $<value>.made)
    }

    method name($/) {
        make $/.Str
    }

    method value($/) {
        with $<lts> {
            make $<lts>.made.Str
        } else {
            make $/.Str
        }
    }

    method lts($/) {
        make $/[0].Str
    }
}

class Tcl::OptionParser::Parser is export {
    method parse(Str $options) {
        my $parsed = Tcl::OptionParser-Grammar.parse($options, :actions(Tcl::OptionParser-Actions.new));
        say ">", $options;
        my %parsed := %(|($parsed.ast));
        for %parsed -> $p {
            if $p.value eq "??" {
                %parsed{$p.key}:delete
            }
        }

        %parsed
    }
}