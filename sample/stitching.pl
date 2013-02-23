#!/usr/bin/perl
# -*- mode: perl; coding: utf-8; tab-width: 4; -*-

use strict;
use warnings;

use lib qw(blib/lib blib/arch);
use Cv;
use Cv::Stitcher;
use Time::HiRes qw(gettimeofday);

my $stitcher = Cv::Stitcher->new(0);
my $t = gettimeofday();
my $pano = $stitcher->stitch([map { Cv::Mat->load($_) } @ARGV]);
printf "%.3f\n", gettimeofday() - $t;
$pano->show;
Cv->waitKey;
