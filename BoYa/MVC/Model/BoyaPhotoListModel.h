//
//  BoyaPhotoList.h
//  BoYa
//
//  Created by Song on 13-6-5.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dragon_JSONReflection.h"

@interface BoyaPhotoListModel : DragonJSONReflection {
    
    NSString *pic_url_s;
}

@property (nonatomic, retain)NSString *pic_url_s;
@end
