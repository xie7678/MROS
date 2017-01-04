//
//  MeetingModel.h
//  MROS
//
//  Created by Sam on 16/12/26.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeetingModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) int meetingId;

- (instancetype) initModelWithName: (NSString *) name X: (int) x;
@end
