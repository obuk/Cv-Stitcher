# -*- mode: perl; coding: utf-8; tab-width: 4 -*-

use strict;
use warnings;
# use Test::More qw(no_plan);
use Test::More tests => 11;
use Test::Exception;
BEGIN { use_ok('Cv::Stitcher') }

my $verbose = Cv->hasGUI;

use File::Basename;
my $imgdir = dirname($0) . "/../sample";

sub wget {
	my $wget = "wget --no-check-certificate";
	my $testdata = 'https://raw.github.com/Itseez/opencv_extra/master/testdata';
	for (@_) {
		unless (-f "$imgdir/$_") {
			my $url = "$testdata/stitching/$_";
			my $r = system("$wget $url && mv $_ $imgdir/");
			die "=" x 20, "\n", "Can't wget $url" if $r;
		}
	}
}

&wget(qw(a1.png a2.png a3.png b1.png b2.png));

if (1) {
	my @png =  glob("$imgdir/a?.png");
	my $stitcher = Cv::Stitcher->new();
	my $pano = $stitcher->stitch([map Cv::Mat->load($_), @png]);
	ok($pano);
	if ($verbose) {
		$pano->show;
		Cv->waitKey(1000);
	}
}

if (2) {
	my @png =  glob("$imgdir/b?.png");
	my $stitcher = Cv::Stitcher->new();
	my $pano = $stitcher->stitch([map Cv::Image->load($_), @png]);
	ok($pano);
	if ($verbose) {
		$pano->show;
		Cv->waitKey(1000);
	}
}

if (10) {
	throws_ok { Cv::Stitcher->new(1, 2, 3) }
	qr/Usage: Cv::Stitcher::new\(CLASS, try_use_gpu=false\) at $0/;
}

if (11) {
	my $stitcher = Cv::Stitcher->new(0);
	throws_ok { $stitcher->stitch() }
	qr/Usage: Cv::Stitcher::stitch\(THIS, imgs\)/;
}

if (12) {
	my @png = glob("$imgdir/?1.png");
	my $stitcher = Cv::Stitcher->new();
	throws_ok { $stitcher->stitch([map Cv::Mat->load($_), @png]) }
	qr/OpenCV Error:/;
}

if (13) {
	my @png = ("$imgdir/a1.png");
	my $stitcher = Cv::Stitcher->new();
	throws_ok { $stitcher->stitch([map Cv::Mat->load($_), @png]) }
	qr/OpenCV Error:/;
}

if (14) {
	my @png =  ("$imgdir/a1.png");
	my $stitcher = Cv::Stitcher->new();
	throws_ok { $stitcher->stitch(1) }
	qr/imgs is not of type CvArr \*\* in Cv::Stitcher::stitch at $0/;
}

if (15) {
	if (1) {
		my $s1 = Cv::Stitcher->new();
		ok($s1);
		my $s2 = Cv::Stitcher->new();
		ok(!$s2);
	}
	if (2) {
		my $s1 = Cv::Stitcher->new();
		ok($s1);
	}
}
