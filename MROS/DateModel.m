//
//  DateModel.m
//  MROS
//
//  Created by Sam on 16/12/27.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "DateModel.h"

@implementation DateModel
- (instancetype) initWithDate: (NSString *) date
                         week: (NSString *) week
{
    self = [super init];
    if (!self) {
        self = [[DateModel alloc] init];
    }
    self.date = date;
    self.week = week;
    
    return self;
}
@end
