# -*- mode: perl; coding: utf-8; tab-width: 4; -*-

use 5.008008;
use ExtUtils::MakeMaker;
use ExtUtils::PkgConfig;

use lib qw(inc);
use Devel::CheckLib;
check_lib_or_exit(lib => 'opencv_stitching');

eval "use Cv::Config";
die "Install Cv before installing this module\n" if $@;
push(@{$Cv::Config::MM{TYPEMAPS}}, "typemap");

WriteMakefile(
	NAME => 'Cv::Stitcher',
	VERSION_FROM => 'lib/Cv/Stitcher.pm',
	ABSTRACT_FROM => 'lib/Cv/Stitcher.pm',
	AUTHOR => 'MASUDA Yuta <yuta.cpan@gmail.com>',
	INC => '-I.',
	PREREQ_PM => { Cv => 0.25 },
	%Cv::Config::MM,
	XSOPT => '-C++ -hiertype',
	clean => {
		FILES => [ "sample/*png" ],
	},
);
