/*
     File: ASImageScrollView.m
 Abstract: Centers image within the scroll view and configures image sizing and display.
  Version: 1.3 modified by Philippe Converset on 22/01/13.
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2012 Apple Inc. All Rights Reserved.
 
 */

#import <Foundation/Foundation.h>
#import "ASImageScrollView.h"

#pragma mark -

@interface ASImageScrollView () <UIScrollViewDelegate>
{
    CGSize _imageSize;

    CGPoint _pointToCenterAfterResize;
    CGFloat _scaleToRestoreAfterResize;
}

@end

@implementation ASImageScrollView

@synthesize _delegateCon,zoomImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bouncesZoom = YES;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.delegate = self;
        self.backgroundColor=[UIColor clearColor];
        self.userInteractionEnabled=YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self getzoomImageView];
        
    }
    return self;
}

-(UIImageView *)getzoomImageView
{
    if (!zoomImageView) {
        zoomImageView=[[UIImageView alloc]init];
        [self addSubview:zoomImageView];
    }
    
    if (zoomImageView.superview) {
        DLogInfo(@"");
    }
    return zoomImageView;
}

-(void)releaseZoomImageView
{
    self.zoomImageView=nil;
}

//滚动UIScrollView会触发
- (void)layoutSubviews 
{
    [super layoutSubviews];
    
    // center the zoom view as it becomes smaller than the size of the screen
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = zoomImageView.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width)
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    else
        frameToCenter.origin.x = 0;
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height)
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    else
        frameToCenter.origin.y = 0;
    
    zoomImageView.frame = frameToCenter;
    
//    NSLog(@"=============================================");
//    NSLog(@"scrollView.frame.w==%f  scrollView.frame.h==%f",self.frame.size.width,self.frame.size.height);//不变
//    NSLog(@"zoomImageView==%@",self.zoomImageView);//zoomImageView.frame在变
//    NSLog(@"contentSize.width==%f contentSize.height===%f",self.contentSize.width,self.contentSize.height);//contentSize根据zoomImageView.frame.frame变
//    NSLog(@"imageView.image.size.w===%f    imageView.image.size.h===%f", self.zoomImageView.image.size.width,self.zoomImageView.image.size.height);//zoomImageView.image.size不变

}

//重写setFrame
- (void)setFrame:(CGRect)frame
{
    BOOL sizeChanging = !CGSizeEqualToSize(frame.size, self.frame.size);
    
    if (sizeChanging) {
//        [self prepareToResize];
    }
    
    [super setFrame:frame];
    
    if (sizeChanging) {
//        [self recoverFromResizing];
    }
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return zoomImageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
//    NSLog(@"contentSize :width==%f,height==%f",self.contentSize.width,self.contentSize.height);
//    
//    NSLog(@"zoomImageView=%@",self.zoomImageView);
//    NSLog(@"imageView.image.size.w===%f    imageView.image.size.h===%f", self.zoomImageView.image.size.width,self.zoomImageView.image.size.height);
}

#pragma mark - Configure scrollView to display new image


- (void)displayImage:(UIImage *)image
{
    if(zoomImageView == nil)
    {
//        self.zoomScale = 1.0;
        
        // make a new UIImageView for the new image
        zoomImageView = [[[UIImageView alloc] initWithImage:image] autorelease];
        [self addSubview:zoomImageView];        
    }
    else
    {
        zoomImageView.image = image;
        if (image) {
            [zoomImageView setFrame:CGRectMake(0, 0, image.size.width ,image.size.height   /*self.frame.size.width,self.frame.size.height*/)];
        }
    }
    
//    NSLog(@"%@",self.zoomImageView);
    
    [self configureForImageSize:image.size];
}

- (void)configureForImageSize:(CGSize)imageSize
{
    _imageSize = imageSize;
    self.contentSize = imageSize;
    [self setMaxMinZoomScalesForCurrentBounds];
    self.zoomScale = self.minimumZoomScale;
}

- (void)setMaxMinZoomScalesForCurrentBounds
{
    CGSize boundsSize = self.bounds.size;
    CGFloat maxScale = 1;
    
    // calculate min/max zoomscale
    CGFloat xScale = boundsSize.width  / _imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / _imageSize.height;   // the scale needed to perfectly fit the image height-wise
    CGFloat minScale = MIN(xScale, yScale);                   // use minimum of these to allow the image to become fully visible
    
    // Image must fit the screen, even if its size is smaller.
    CGFloat xImageScale = maxScale*_imageSize.width / boundsSize.width;
    CGFloat yImageScale = maxScale*_imageSize.height / boundsSize.width;
    CGFloat maxImageScale = MAX(xImageScale, yImageScale);
    
    maxImageScale = MAX(minScale, maxImageScale);
    maxScale = MIN(maxScale, maxImageScale);
    
    // don't let minScale exceed maxScale. (If the image is smaller than the screen, we don't want to force it to be zoomed.)
    if (minScale > maxScale) {
        minScale = maxScale;
    }

    self.maximumZoomScale = maxScale/**1.5*/;
    self.minimumZoomScale = (minScale);
    
//    LogRect(__FUNCTION__, screen);
//    LogRect(__FUNCTION__, screenShows);

}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	//YBLogInfo(@"%s", _cmd);
//    
//	UITouch *touch = [touches anyObject];
//    [super touchesBegan:touches withEvent:event];
//    
////    CGPoint touchPoint = [[touches anyObject] locationInView:self];
////    self.pointS = touchPoint;
////    YBLogInfo(@"count is %d",[touch tapCount]);
////	if ([touch tapCount] == 2)
////	{
////		//YBLogInfo(@"double click");
////		CGFloat zs = self.zoomScale;
////		zs = (zs == 1.0) ? kMaxZoom : 1.0;
////        if (zs==kMaxZoom) {
////            self.scrollSetFlag = 1;
////        }else {
////            self.scrollSetFlag = 0;
////        }
////		[UIView beginAnimations:nil context:NULL];
////        [UIView setAnimationDelegate:self];
////		[UIView setAnimationDuration:0.3];
////        self.zoomScale = zs;
////        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
////		[UIView commitAnimations];
////	}
////    else
//        if ([touch tapCount] == 1)
//    {
//        if ([self.delegate respondsToSelector:@selector(getDanDian)])
//        {
//            [self.delegate performSelector:@selector(getDanDian)];
//        }
//    }
//}

#pragma mark -
#pragma mark Methods called during rotation to preserve the zoomScale and the visible portion of the image

#pragma mark - Rotation support

- (void)prepareToResize
{
    CGPoint boundsCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _pointToCenterAfterResize = [self convertPoint:boundsCenter toView:zoomImageView];

    _scaleToRestoreAfterResize = self.zoomScale;
    
    // If we're at the minimum zoom scale, preserve that by returning 0, which will be converted to the minimum
    // allowable scale when the scale is restored.
    if (_scaleToRestoreAfterResize <= self.minimumZoomScale + FLT_EPSILON)
        _scaleToRestoreAfterResize = 0;
}

- (void)recoverFromResizing
{
    [self setMaxMinZoomScalesForCurrentBounds];
    
    // Step 1: restore zoom scale, first making sure it is within the allowable range.
    CGFloat maxZoomScale = MAX(self.minimumZoomScale,self.maximumZoomScale /*_scaleToRestoreAfterResize*/  );
    self.zoomScale = MIN(self.maximumZoomScale, maxZoomScale);
    
    // Step 2: restore center point, first making sure it is within the allowable range.
    
    // 2a: convert our desired center point back to our own coordinate space
    CGPoint boundsCenter = [self convertPoint:_pointToCenterAfterResize fromView:zoomImageView];

    // 2b: calculate the content offset that would yield that center point
    CGPoint offset = CGPointMake(boundsCenter.x - self.bounds.size.width / 2.0,
                                 boundsCenter.y - self.bounds.size.height / 2.0);

    // 2c: restore offset, adjusted to be within the allowable range
    CGPoint maxOffset = [self maximumContentOffset];
    CGPoint minOffset = [self minimumContentOffset];
    
    CGFloat realMaxOffset = MIN(maxOffset.x, offset.x);
    offset.x = MAX(minOffset.x, realMaxOffset);
    
    realMaxOffset = MIN(maxOffset.y, offset.y);
    offset.y = MAX(minOffset.y, realMaxOffset);
    
    self.contentOffset = offset;
}

- (CGPoint)maximumContentOffset
{
    CGSize contentSize = self.contentSize;
    CGSize boundsSize = self.bounds.size;
    return CGPointMake(contentSize.width - boundsSize.width, contentSize.height - boundsSize.height);
}

- (CGPoint)minimumContentOffset
{
    return CGPointZero;
}


#pragma mark- NSNotificationCenter
//static char ori_y;//imgV的原始y

-(void)handleNotification
{
    //    self.contentSize=self.imageView.image.size;
    
    //    NSString *_str_ori_y=[NSString stringWithFormat:@"%f",self.center.y-self.imageView.image.size.height/2];
    //    objc_setAssociatedObject(self, &ori_y, _str_ori_y, OBJC_ASSOCIATION_RETAIN);
    
    self.userInteractionEnabled=YES;
    ((UIScrollView *)self.superview).userInteractionEnabled=YES;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:k_Notification_SuccessDownImg object:nil];
    
    [self displayImage:zoomImageView.image];
    
//    [DeBug CreatTapGeture:self._delegateCon selector:@selector(getDanDian) addInView:self numberOfTouchesRequired:1 numberOfTapsRequired:1];

}

-(void) dealloc
{
    [zoomImageView removeFromSuperview];
    [zoomImageView release];
//    self.zoomImageView=Nil;
    [super dealloc];
}

@end