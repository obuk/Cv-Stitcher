# -*- mode: perl; coding: utf-8; tab-width: 4; -*-

package Cv::Stitcher;

use 5.008008;
use strict;
use warnings;
use Cv ();
require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = ();

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('Cv::Stitcher', $VERSION);

1;
__END__
=encoding utf8

=head1 NAME

Cv::Stitcher - Cv extension for OpenCV Stitcher

=head1 SYNOPSIS

  use Cv;
  use Cv::Stitcher;
  my $stitcher = Cv::Stitcher->createDefault();
  my $pano = $stitcher->stitch([map { Cv::Mat->load($_) } @ARGV]);
  $pano->show;
  Cv->waitKey;

=head1 DESCRIPTION

This package is a perl extention for OpenCV Stitcher.
see http://docs.opencv.org/trunk/modules/stitching/doc/high_level.html
Please use with L<Cv>.

=head2 METHOD

=over

=item Cv::Stitcher::createDefault(bool try_use_gpu = false)

Creates a Cv::Stitcher instance.

=item Stitcher::stitch(CvArr** images)

This function stitches given images.  Return value is a stitched image
created.  You can use eval { } to catch internal error.

  my $pano = eval {  $stitcher->stitch([@imgs]) };

=back

=head2 EXPORT

None by default.

=head2 BUG

=over

=item *

Stitcher instance is only one per process.

=back


=head1 SEE ALSO

http://github.com/obuk/Cv-Olive


=head1 AUTHOR

MASUDA Yuta E<lt>yuta.cpan@gmail.comE<gt>

=head1 LICENCE

Copyright (c) 2010, 2011, 2012 by Masuda Yuta.

All rights reserved. This program is free software; you can
redistribute it and/or modify it under the same terms as Perl itself.

=cut
