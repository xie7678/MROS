//
//  CustomButton.m
//  MROS
//
//  Created by Sam on 16/12/26.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "CustomButton.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation CustomButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (instancetype) initWithMeetingAndReserve: (MeetingAndReserveModel *) meeting buttonType: (UIButtonType)buttonType frame: (CGRect) frame {
    
   CustomButton *btn = [super buttonWithType: buttonType];
    
    btn.frame = frame;
    
    if (btn) {
        
        btn.model = meeting;
        
        btn.layer.borderWidth = 1;
        
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        
        btn.layer.cornerRadius = 5;
        
        btn.layer.borderColor = btn.model.status == 0 ? [UIColor lightGrayColor].CGColor : [UIColor whiteColor].CGColor;
        
        [btn setTitle:btn.model.status == 0 ? @"不可预定" : @"可预定" forState:UIControlStateNormal];
        
        [btn setTitleColor:btn.model.status == 0 ? [UIColor lightGrayColor] : [UIColor whiteColor] forState:UIControlStateNormal];
        
        btn.enabled = btn.model.status == 0 ? NO : YES;
        
//        [btn setBackgroundColor:[UIColor lightGrayColor]];
        
//        [btn addTarget:btn action:@selector(touchUpInsideSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            btn.model.isOfSelected = !btn.model.isOfSelected;
            
            btn.layer.borderColor = btn.model.isOfSelected ? [UIColor greenColor].CGColor : [UIColor whiteColor].CGColor;
            
            [btn setTitleColor:btn.model.isOfSelected ? [UIColor greenColor] : [UIColor whiteColor] forState:UIControlStateNormal];
            
            [btn setTitle:btn.model.isOfSelected ? @"已选定" : @"可预定" forState:UIControlStateNormal];
            
            if ([btn.delegate respondsToSelector:@selector(getSelectedWithMeetingModel:)]) {
                [btn.delegate getSelectedWithMeetingModel:btn.model];
            }
            
        }];
    }
    
    return btn;
}
//- (void) creatBtnWithType {
//    
//    self.layer.borderWidth = 1;
//    
//    self.layer.borderColor = _model.status == 0 ? [UIColor lightGrayColor].CGColor : [UIColor whiteColor].CGColor;
//    
//    [self setTitle:_model.status == 0 ? @"可预定" : @"不可预定" forState:UIControlStateNormal];
//    
//    [self setTitleColor:_model.status == 0 ? [UIColor lightGrayColor] : [UIColor whiteColor] forState:UIControlStateNormal];
//    
//    self.enabled = _model.status == 0 ? NO : YES;
//    
//    [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        
//        _model.isOfSelected = !_model.isOfSelected;
//        
//        self.layer.borderColor = _model.isOfSelected ? [UIColor orangeColor].CGColor : [UIColor whiteColor].CGColor;
//        
//        if ([self.delegate respondsToSelector:@selector(getSelectedWithMeetingModel:)]) {
//            [self.delegate getSelectedWithMeetingModel:_model];
//        }
//        
//    }];
//    
//}

@end
