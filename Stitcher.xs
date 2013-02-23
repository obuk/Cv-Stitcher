/* -*- mode: text; coding: utf-8; tab-width: 4 -*- */

#include "Cv.inc"

#if defined __FreeBSD__ || defined __CYGWIN__
#  undef Null
#endif

#include "opencv2/stitching/stitcher.hpp"

/* Global Data */
#define MY_CXT_KEY "Cv::Stitcher::_guts" XS_VERSION

typedef struct {
	int used;
} my_cxt_t;

START_MY_CXT

MODULE = Cv::Stitcher		PACKAGE = Cv::Stitcher

Stitcher*
Stitcher::new(bool try_use_gpu=false)
ALIAS: createDefault = 1
CODE:
	dMY_CXT;
	if (MY_CXT.used) XSRETURN_UNDEF;
	MY_CXT.used = 1;
	static Stitcher stitcher = Stitcher::createDefault(try_use_gpu);
	RETVAL = &stitcher;
OUTPUT:
	RETVAL


CvMat*
Stitcher::stitch(CvArr** imgs);
CODE:
	vector<Mat> _imgs; Mat _pano;
	for (int i = 0; i < length(imgs); i++) {
		_imgs.push_back(cvarrToMat(imgs[i]));
	}
	Stitcher::Status status = THIS->stitch(_imgs, _pano);
	if (status != Stitcher::OK) {
		const char *pname = "Stitcher::stitch";
		if (status == Stitcher::ERR_NEED_MORE_IMGS)
			cvError(-2, pname, "Need more images", __FILE__, __LINE__);
		cvError(-2, pname, "Unknown error", __FILE__, __LINE__);
	}
	CvMat pano = _pano;
	RETVAL = cvCloneMat(&pano);
OUTPUT:
	RETVAL


void
Stitcher::DESTROY()
CODE:
	dMY_CXT;
	MY_CXT.used = 0;


MODULE = Cv::Stitcher		PACKAGE = Cv::Stitcher

BOOT:
	/* Setup Global Data */
	MY_CXT_INIT;
	MY_CXT.used = 0;

void
CLONE(...)
CODE:
	MY_CXT_CLONE;
