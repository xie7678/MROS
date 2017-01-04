//
//  MeetingAndReserveModel.h
//  MROS
//
//  Created by Sam on 16/12/26.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeetingAndReserveModel : NSObject

@property (nonatomic, assign) int y;

@property (nonatomic, assign) int x;

@property (nonatomic, assign) int status;

@property (nonatomic, strong) NSString *date;

@property (nonatomic, assign) BOOL isOfSelected;

- (instancetype) initModelWithMeetingX: (int) x
                                 timeY: (int) y
                                status: (int) status;

@end
