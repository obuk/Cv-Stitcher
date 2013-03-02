# -*- mode: perl; coding: utf-8; tab-width: 4; -*-

use 5.008008;
use ExtUtils::MakeMaker;

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
	%PREREQ_PM,
	%Cv::Config::MM,
	XSOPT => '-C++ -hiertype',
	clean => {
		FILES => [ "sample/*png" ],
	},
);
