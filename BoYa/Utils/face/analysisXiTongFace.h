//
//  analysisXiTongFace.h
//  Yiban
//
//  Created by tom zeng on 13-3-8.
//
//

#import <Foundation/Foundation.h>
#import "target.h"
@interface analysisXiTongFace : NSObject{
    BOOL konwFace;

}
@property(nonatomic,retain)NSArray *targets;
-(NSString*)outString:(NSString*)inString;
-(NSString*)getImageRange:(NSString*)message : (NSMutableArray*)array;
@end
