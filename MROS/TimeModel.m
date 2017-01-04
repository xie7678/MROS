//
//  TimeModel.m
//  MROS
//
//  Created by Sam on 16/12/26.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "TimeModel.h"

@implementation TimeModel

- (instancetype) initModelWithName: (NSString *) name Y: (int) y {
    
    self = [super init];
    if (self) {
        self.name = name;
        self.timeId = y;
    }
    
    return self;
}

@end
