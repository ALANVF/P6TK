use Tk;

my $root = Tk::Root.new;

$root.main: {
	$root<l1> = Tk::Label.new(text => "Hello, world!");
	$root<l1>.pack;
};
