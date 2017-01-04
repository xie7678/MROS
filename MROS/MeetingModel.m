//
//  MeetingModel.m
//  MROS
//
//  Created by Sam on 16/12/26.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "MeetingModel.h"

@implementation MeetingModel
- (instancetype) initModelWithName: (NSString *) name X: (int) x {
    
    self = [super init];
    if (self) {
        self.name = name;
        self.meetingId = x;
    }
    
    return self;
}
@end
