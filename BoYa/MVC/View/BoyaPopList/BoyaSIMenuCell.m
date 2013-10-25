//
//  SAMenuCell.m
//  NavigationMenu
//
//  Created by Ivan Sapozhnik on 2/19/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import "BoyaSIMenuCell.h"
#import "BoyaSIMenuConfiguration.h"
#import "UIColor+Extension.h"
#import "BoyaSICellSelection.h"
#import <QuartzCore/QuartzCore.h>
#import "UITableView+property.h"

@interface BoyaSIMenuCell ()
@property (nonatomic, strong) BoyaSICellSelection *cellSelection;
@end

@implementation BoyaSIMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tbv:(UITableView *)tbv
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = /*[UIColor color:[BoyaSIMenuConfiguration itemsColor] withAlpha:[BoyaSIMenuConfiguration menuAlpha]]*/ [UIColor blackColor];
        self.contentView.alpha=0.85;
        self.textLabel.textColor = [BoyaSIMenuConfiguration itemTextColor];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.shadowColor = [UIColor darkGrayColor];
        self.textLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        
        self.selectionStyle = UITableViewCellEditingStyleNone;
        
        self.cellSelection = [[BoyaSICellSelection alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, tbv._cellH) andColor:/*[BoyaSIMenuConfiguration selectionColor]*/ [UIColor colorWithRed:0 green:134/255.0f blue:139/255.0f alpha:1]];
        [self.cellSelection.layer setCornerRadius:6.0];
        [self.cellSelection.layer setMasksToBounds:YES];
        
        self.cellSelection.alpha = 0.0;
        [self.contentView insertSubview:self.cellSelection belowSubview:self.textLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 2.0f);
    
    CGContextSetRGBStrokeColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
    CGContextMoveToPoint(ctx, 0, self.contentView.bounds.size.height);
    CGContextAddLineToPoint(ctx, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    CGContextStrokePath(ctx);
    
    CGContextSetRGBStrokeColor(ctx, 1.0f, 1.0f, 1.0f, 0.7f);
        
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, self.contentView.bounds.size.width, 0);
    CGContextStrokePath(ctx);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setSelected:(BOOL)selected withCompletionBlock:(void (^)())completion
{
    float alpha = 0.0;
    if (selected) {
        alpha = 1.0;
    } else {
        alpha = 0.0;
    }
    [UIView animateWithDuration:[BoyaSIMenuConfiguration selectionSpeed] animations:^{
        self.cellSelection.alpha = alpha;
    } completion:^(BOOL finished) {
        completion();
    }];
}

- (void)dealloc
{
    self.cellSelection = nil;
}

@end
