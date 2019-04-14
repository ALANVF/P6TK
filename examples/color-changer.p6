use Tk;

my $root = Tk::Root.new;

$root.main: {
	$root.win.geometry(200, 200);

	$root<green-btn>  = Tk::Button.new(
		text => "green",
		fg   => "green"
	);
	$root<red-btn>    = Tk::Button.new(
		text => "red",
		fg   => "red"
	);
	$root<color-area> = Tk::Frame.new(
		width  => 100,
		height => 100,
		bg     => "green"
		);

	$root<green-btn>.command({
		$root<color-area>.bg("green")
	});
	$root<red-btn>.command({
		$root<color-area>.bg("red")
	});

	$root<green-btn>.pack;
	$root<color-area>.pack;
	$root<red-btn>.pack;
};
