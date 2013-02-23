# -*- mode: perl; coding: utf-8; tab-width: 4; -*-

use 5.008008;
use ExtUtils::MakeMaker;

use Cv::Config;
my $cf = new Cv::Config;

my $PREREQ_PM = {
	ExtUtils::ParseXS => 2.22,
};

if ($^O eq 'cygwin') {
	$PREREQ_PM = {
		%$PREREQ_PM,
		Cv => 0.25,
		ExtUtils::MM_Cygwin => 6.62,
		Test::Number::Delta => 1.03,
		Test::Exception => 0.31,
	};
}

WriteMakefile(
	NAME => 'Cv::Stitcher',
	VERSION_FROM => 'lib/Cv/Stitcher.pm',
	PREREQ_PM => $PREREQ_PM,
	ABSTRACT_FROM => 'lib/Cv/Stitcher.pm',
	AUTHOR => 'MASUDA Yuta <yuta.cpan@gmail.com>',
	INC => '-I.',
	LIBS => $cf->libs,
	CC => $cf->cc,
	LD => $cf->cc,
	XSOPT => '-C++ -hiertype',
	TYPEMAPS => [ @{$cf->typemaps}, "typemap" ],
	CCFLAGS => $cf->ccflags,
	OPTIMIZE => '-g',
	clean => {
		FILES => [ "sample/*png" ],
	},
);
