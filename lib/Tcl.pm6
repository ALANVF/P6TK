unit module Tcl;
use Tcl::Stream;
use Tcl::OptionParser;
use Tcl::Interp;

our sub signal(Positional $args) is export {
    "puts \"{$args.join: " "}\""
}