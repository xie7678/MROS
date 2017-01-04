//
//  ReserveScrollView.h
//  MROS
//
//  Created by Sam on 16/12/28.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MeetingModel.h"

#import "TimeModel.h"

#import "MeetingAndReserveModel.h"

#import "CustomButton.h"

@protocol MeetingReservedDelegate <NSObject>

- (void) getReservedMeetingWithArray: (NSArray *) array;

@end

@interface ReserveScrollView : UIScrollView<SelectedMeetingDelegate>

@property (nonatomic, strong) NSString *dateStr;

@property (nonatomic, strong) NSArray *meetingArr;

@property (nonatomic, strong) NSArray *timeArr;

@property (nonatomic, strong) NSArray *contentArr;

@property (nonatomic, strong) UIView *meetingView;

@property (nonatomic, strong) UIView *timeView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) NSMutableArray *selectedMeetingMArr;

@property (nonatomic, weak) id <MeetingReservedDelegate> meetingDelegate;

- (instancetype) initScrollWithMeetingArr: (NSArray *) meetingArr
                                  timeArr: (NSArray *) timeArr
                               contentArr: (NSArray *) contentArr
                                    frame: (CGRect) frame;

- (void) refreshScrollWithMeetingArr: (NSArray *) meetingArr
                             timeArr: (NSArray *) timeArr
                          contentArr: (NSArray *) contentArr;
@end
