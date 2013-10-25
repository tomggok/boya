//
//  BoyaPhotoList.m
//  BoYa
//
//  Created by Song on 13-6-5.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaPhotoListModel.h"

@implementation BoyaPhotoListModel
@synthesize pic_url_s;

- (void)dealloc{
    RELEASEOBJ(pic_url_s);
    
    [super dealloc];
}
@end
