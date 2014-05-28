#!/usr/bin/perl

use strict;

use Getopt::Std;
use GD::Graph::linespoints;
use Text::ParseWords;

# --------------------------------------------------
# setup
# --------------------------------------------------

my %opts = ();
getopts('d:c:k', \%opts);

my $config_file = ($opts{'c'} || "csv2png.conf");
my $delimiter   = ($opts{'d'} || ';');
my $keep        = ($opts{'k'} || 0);

my $input_file  = $ARGV[0];
my ($output_file) = ($input_file =~ /(.*)\./);

die usage() unless ($input_file && $output_file);

# sets globals %graph, %config and @legends
use vars qw(%graph %config @legends);

# can't use do() here because of PerlApp limitations :-(
{
	open(CF, "<$config_file") or die "Error: no open for $config_file: $!";
	local $/ = undef;
	my $configuration = <CF>;
	eval "$configuration";
	close(CF);
}
	

# --------------------------------------------------
# action
# --------------------------------------------------

my @data =  read_data_from_csv($input_file);

my $my_graph = new GD::Graph::linespoints($graph{'width'}, $graph{'height'});

$my_graph->set(%config); 
$my_graph->set_legend(@legends);

$my_graph->plot(\@data);
save_chart($my_graph, $output_file);

# --------------------------------------------------
# subs
# --------------------------------------------------

sub read_data_from_csv
{
	my ($fh) = @_;
	my @d = ();

	open(FH, "<$fh") || die "Error: no open for $fh: $!";
	while (<FH>) {
		chomp;
		my @row = parse_line($delimiter, $keep, $_);
		for (my $i = 0; $i <= $#row; $i++) {
			undef $row[$i] if ($row[$i] eq 'undef');
			push @{$d[$i]}, $row[$i];
		}
	}
	close (FH);
	return @d;
}

sub usage {
	print << "EOU";

Usage: $0 [-d][-k][-c] input-filename

$0: reads a CSV file and creates a PNG line graphic from it
Options:
	c: configuration file name (default "csv2png.conf")
	d: delimiter for CSV file (Perl regular expression, default ";")
	k: keep quotes around data (default off)

EOU
}

sub save_chart
{
	my ($chart, $name) = @_; 
	local(*OUT);
	my $ext = $chart->export_format;
	open(OUT, ">$name.$ext") or 
		die "Cannot open $name.$ext for write: $!";
	binmode OUT;
	print OUT $chart->gd->$ext();
	close OUT;
}

1;

##</code><code>##

# must create the following variables:
# %config (graph options, see perldoc GD::Graph)
# @legends (graph methods, see perldoc GD::Graph)

%graph = (
	width => 600,
	height => 400,
);

%config = ( 
	width         => 600,
	height        => 400,
	x_label       => 'X-Axis',
	y_label       => 'Y-Axis',
	title         => 'Chart',
	y_min_value   => '0',
	y_max_value   => '5000',
	y_tick_number => '10',
	y_label_skip  => '2',

	transparent   => 0,
	bgclr         => 'white',
);

@legends = (
	'Page Views',
	'Visits',
);