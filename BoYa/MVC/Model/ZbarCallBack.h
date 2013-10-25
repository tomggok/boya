//
//  ZbarCallBack.h
//  ZbarSDKForYiban
//
//  Created by 周 哲 on 13-5-21.
//  Copyright (c) 2013年 周 哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZbarCallBack <NSObject>
@optional
-(void)callBackForDimensionCode :(NSString *)code;
@end
