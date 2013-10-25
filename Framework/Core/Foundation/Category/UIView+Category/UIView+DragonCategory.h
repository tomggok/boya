//
//  UIView+DragonCategory.h
//  DragonFramework
//
//  Created by NewM on 13-3-6.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView(DragonCategory)

@property (nonatomic,assign) CGRect _originFrame;

- (UIViewController *)viewController;

-(void)changePosInSuperViewWithAlignment:(NSUInteger)Alignment;

@end
