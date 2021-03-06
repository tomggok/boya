//
// SVSegmentedThumb.m
// SVSegmentedControl
//
// Created by Sam Vermette on 25.05.11.
// Copyright 2011 Sam Vermette. All rights reserved.
//
// https://github.com/samvermette/SVSegmentedControl
//

#import "Dragon_UISegmentedThumb.h"
#import <QuartzCore/QuartzCore.h>
#import "Dragon_UISegmentedControl.h"

@interface DragonUISegmentedThumb ()

@property (nonatomic, readwrite) BOOL selected;
@property (nonatomic, unsafe_unretained) DragonUISegmentedControl *segmentedControl;
@property (nonatomic, unsafe_unretained) UIFont *font;

@property (strong, nonatomic, readonly) UILabel *label;
@property (strong, nonatomic, readonly) UILabel *secondLabel;
@property (strong,nonatomic) UIImage* showImage;
- (void)activate;
- (void)deactivate;

@end


@implementation DragonUISegmentedThumb

@synthesize segmentedControl, backgroundImage, highlightedBackgroundImage, font, tintColor, textColor, textShadowColor, textShadowOffset, shouldCastShadow, selected;
@synthesize label, secondLabel;

// deprecated properties
@synthesize shadowColor, shadowOffset, castsShadow;



- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
	
    if (self) {
		self.userInteractionEnabled = NO;
		self.backgroundColor = [UIColor clearColor];
		self.textColor = [UIColor whiteColor];
		self.textShadowColor = [UIColor clearColor];
		self.textShadowOffset = CGSizeMake(0, -1);
		self.tintColor = [UIColor grayColor];
        self.shouldCastShadow = YES;
    }
	
    return self;
}
-(void)setTitleData:(id)title
{
    if([title isKindOfClass:[NSString class]])
    {
        self.showImage = nil;
        self.label.text = title;
    }
    if([title isKindOfClass:[UIImage class]])
    {
        self.showImage = title;
        self.label.text = nil;
    }
}
- (UILabel*)label {
    
    if(label == nil) {
        label = [[UILabel alloc] initWithFrame:self.bounds];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
		label.textAlignment = UITextAlignmentCenter;
#else
        label.textAlignment = NSTextAlignmentCenter;
#endif
		label.font = self.font;
		label.backgroundColor = [UIColor clearColor];
		[self addSubview:label];
    }
    
    return label;
}

- (UILabel*)secondLabel {
    
    if(secondLabel == nil) {
		secondLabel = [[UILabel alloc] initWithFrame:self.bounds];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
		secondLabel.textAlignment = UITextAlignmentCenter;
#else
        secondLabel.textAlignment = NSTextAlignmentCenter;
#endif
		secondLabel.font = self.font;
		secondLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:secondLabel];
    }
    
    return secondLabel;
}

- (UIFont *)font {
    return self.label.font;
}


- (void)drawRect:(CGRect)rect {
        
    if(self.backgroundImage && !self.selected)
        [self.backgroundImage drawInRect:rect];
    
    else if(self.highlightedBackgroundImage && self.selected)
        [self.highlightedBackgroundImage drawInRect:rect];
    
    else {
        
//        CGFloat cornerRadius = self.segmentedControl.cornerRadius;
//        
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
//
//        // STROKE GRADIENT
//        
//        CGPathRef strokeRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius-1.5].CGPath;
//        CGContextAddPath(context, strokeRect);
//        CGContextClip(context);
//
//        CGContextSaveGState(context);
//
//        CGFloat strokeComponents[4] = {/*0.55*/ (CGFloat)(218/255)  , 0, /*0.40*/ (CGFloat)(64/255), 0};//选中框的边框颜色
//
//        if(self.selected) {
//            strokeComponents[0]-=0.1;
//            strokeComponents[2]-=0.1;
//        }
//
//        CGGradientRef strokeGradient = CGGradientCreateWithColorComponents(colorSpace, strokeComponents, NULL, 2);	
//        CGContextDrawLinearGradient(context, strokeGradient, CGPointMake(0,0), CGPointMake(0,CGRectGetHeight(rect)), 0);
//        CGGradientRelease(strokeGradient);

        
        // FILL GRADIENT
//        CGPathRef fillRect = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 1, 1) cornerRadius:cornerRadius-2.5].CGPath;
//        CGContextAddPath(context, fillRect);
//        CGContextClip(context);
//        
//        CGFloat fillComponents[4] = {0.5 /*0*/, 0,   0.35 /*0*/, 0};
//        
//        if(self.selected) {
//            fillComponents[0]-=0.1;
//            fillComponents[2]-=0.1;
//        }

//        CGGradientRef fillGradient = CGGradientCreateWithColorComponents(colorSpace, fillComponents, NULL, 2);	
//        CGContextDrawLinearGradient(context, fillGradient, CGPointMake(0,0), CGPointMake(0,CGRectGetHeight(rect)), 0);
//        CGGradientRelease(fillGradient);

//        CGColorSpaceRelease(colorSpace);

//        CGContextRestoreGState(context);
//        [self.tintColor set];
//        UIRectFillUsingBlendMode(rect, kCGBlendModeNormal);

        if(self.showImage)
        {
            [self.showImage drawInRect:rect];
        }
    }
}


#pragma mark -
#pragma mark Setters

- (void)setBackgroundImage:(UIImage *)newImage {
    
    if(backgroundImage)
        backgroundImage = nil;
    
    if(newImage) {
        backgroundImage = newImage;
        self.shouldCastShadow = NO;
    } else {
        self.shouldCastShadow = YES;
    }
}

- (void)setTintColor:(UIColor *)newColor {
    
    if(tintColor)
        tintColor = nil;
	
	if(newColor)
		tintColor = newColor;

	[self setNeedsDisplay];
}

- (void)setFont:(UIFont *)newFont {
    self.label.font = self.secondLabel.font = newFont;
}

- (void)setTextColor:(UIColor *)newColor {
	self.label.textColor = self.secondLabel.textColor = newColor;
}

- (void)setTextShadowColor:(UIColor *)newColor {
	self.label.shadowColor = self.secondLabel.shadowColor = newColor;
}

- (void)setTextShadowOffset:(CGSize)newOffset {
	self.label.shadowOffset = self.secondLabel.shadowOffset = newOffset;
}

- (void)setShouldCastShadow:(BOOL)b {
    self.layer.shadowOpacity = b ? 1 : 0;
}


#pragma mark -

- (void)setFrame:(CGRect)newFrame {
	[super setFrame:newFrame];
        
    CGFloat posY = ceil((self.segmentedControl.height-self.font.pointSize+self.font.descender)/2)+self.segmentedControl.titleEdgeInsets.top-self.segmentedControl.titleEdgeInsets.bottom-self.segmentedControl.thumbEdgeInset.top+2;
	int pointSize = self.font.pointSize;
	
	if(pointSize%2 != 0)
		posY--;
    
	self.label.frame = self.secondLabel.frame = CGRectMake(0, posY, newFrame.size.width, self.font.pointSize);
    
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 1;
    self.layer.shadowColor = [UIColor blackColor /*clearColor */].CGColor;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.segmentedControl.cornerRadius-1].CGPath;
    self.layer.shouldRasterize = YES;
}


- (void)setSelected:(BOOL)s {
	
	selected = s;
	
	if(selected && !self.segmentedControl.crossFadeLabelsOnDrag && !self.highlightedBackgroundImage)
		self.alpha = 0.8;
	else
		self.alpha = 1;
	
	[self setNeedsDisplay];
}

- (void)activate {
	[self setSelected:NO];
    
    if(!self.segmentedControl.crossFadeLabelsOnDrag)
        self.label.alpha = 1;
}

- (void)deactivate {
	[self setSelected:YES];
    
    if(!self.segmentedControl.crossFadeLabelsOnDrag)
        self.label.alpha = 0;
}

#pragma mark - Support for deprecated methods

- (void)setShadowOffset:(CGSize)newOffset {
    self.textShadowOffset = newOffset;
}

- (void)setShadowColor:(UIColor *)newColor {
    self.textShadowColor = newColor;
}

- (void)setCastsShadow:(BOOL)b {
    self.shouldCastShadow = b;
}

@end
