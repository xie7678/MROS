//
//  Tool.h
//  MROS
//
//  Created by Sam on 16/12/27.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

+ (void) getDateWithResult: (void (^) (NSArray *arr)) result;

@end
