//
//  CustomButton.h
//  MROS
//
//  Created by Sam on 16/12/26.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MeetingAndReserveModel.h"

typedef NS_ENUM(NSInteger, CustomButtonStatus) {
    CustomButtonStatusCustom = 0,                         // no button type
    CustomButtonStatusDont,
};

@protocol SelectedMeetingDelegate <NSObject>

- (void) getSelectedWithMeetingModel:(MeetingAndReserveModel *) model;

@end

@interface CustomButton : UIButton

@property (nonatomic, strong) MeetingAndReserveModel *model;


@property (nonatomic, weak) id <SelectedMeetingDelegate> delegate;

+ (instancetype) initWithMeetingAndReserve: (MeetingAndReserveModel *) meeting buttonType: (UIButtonType) buttonType frame: (CGRect) frame;

@end
