use Tk;
use Test;

my $root = Tk::Root.new;

$root.main: {
	$root<b1> = Tk::Button.new(:text<banana>);

	$root<b1>.command({
		$root.quit
	});

	$root<b1>.pack;
};

done-testing;
