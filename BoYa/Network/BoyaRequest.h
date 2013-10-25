//
//  BoyaRequest.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-29.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dragon_Request.h"
#import "Dragon_RequestQueue.h"
#import "BoyaNoticeView.h"

@interface BoyaRequest : NSObject{
    id receive;//接受者
    
    NSMutableDictionary *requestData;//请求数据
    
    NSString *time;//保存sql的时间
    
    BoyaNoticeView *httpRequestView;//网络请求时的
}

- (DragonRequest *)BOYAGET:(NSMutableDictionary *)params isAlert:(BOOL)isAlert receive:(id)_receive;
- (void)handleLogout;

@end
