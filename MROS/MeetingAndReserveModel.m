//
//  MeetingAndReserveModel.m
//  MROS
//
//  Created by Sam on 16/12/26.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "MeetingAndReserveModel.h"

@implementation MeetingAndReserveModel

- (instancetype) initModelWithMeetingX: (int) x
                                 timeY: (int) y
                                status: (int) status
//                                      date: (NSString *) date
{
    
    self = [super init];
    if (self) {
        self.x = x;
        self.y = y;
        self.status = status;
        self.isOfSelected = NO;
    }
    
    return self;
}

@end
