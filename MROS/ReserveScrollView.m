//
//  ReserveScrollView.m
//  MROS
//
//  Created by Sam on 16/12/28.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "ReserveScrollView.h"
#import "MeetingAndReserveModel.h"
#import "Tool.h"
#import "MainData.h"

#define TITLEWIDTH 80

#define TIMEHeight 30

#define DEFAULTCOLOR [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0]



@implementation ReserveScrollView


- (instancetype) initScrollWithMeetingArr: (NSArray *) meetingArr
                                  timeArr: (NSArray *) timeArr
                               contentArr: (NSArray *) contentArr
                                    frame: (CGRect) frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = DEFAULTCOLOR;
        
        self.meetingArr = meetingArr;
        
        self.timeArr = timeArr;
        
        self.contentArr = contentArr;
        
        self.contentSize = CGSizeMake((meetingArr.count + 1) * TITLEWIDTH, (timeArr.count + 1) * TIMEHeight);
        
        [self creatBackView];
        
    }
    
    return self;
}

#pragma mark - refresh

- (void) refreshScrollWithMeetingArr: (NSArray *) meetingArr
                             timeArr: (NSArray *) timeArr
                          contentArr: (NSArray *) contentArr {
    
    
}

#pragma mark - creatView

- (void) creatBackView {
    
    if (_backView) {
        [_backView removeFromSuperview];
    }
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
    
    [self addSubview:_backView];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    
    [_backView addGestureRecognizer:pinch];
    
    [self creatTimeView];
    
    [self creatMeetingView];
    
    [self creatContentView];
    
    _contentView.layer.zPosition = 1;
    
    _meetingView.layer.zPosition = 2;
    
    _timeView.layer.zPosition = 3;
    
}

- (void) creatMeetingView {
    
    if (_meetingView) {
        [_meetingView removeFromSuperview];
    }
    
    _meetingView = [[UIView alloc] initWithFrame:CGRectMake(TITLEWIDTH, 0, (self.meetingArr.count + 1) * TITLEWIDTH, TIMEHeight)];
    
    [_backView addSubview:_meetingView];
    
    [self.meetingArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        MeetingModel *model = (MeetingModel *)obj;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((idx) * TITLEWIDTH, 0, TITLEWIDTH, TIMEHeight)];
        
        titleLabel.font = [UIFont systemFontOfSize:13.0];
        
        titleLabel.layer.borderWidth = 1;
        
        titleLabel.layer.borderColor = [UIColor orangeColor].CGColor;
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        titleLabel.text = model.name;
        
        titleLabel.backgroundColor = DEFAULTCOLOR;
        
        [_meetingView addSubview:titleLabel];
        
    }];
    
}

- (void) creatTimeView {
    
    if (_timeView) {
        [_timeView removeFromSuperview];
    }
    _timeView = [[UIView alloc] initWithFrame:CGRectMake(0, TIMEHeight, TITLEWIDTH, TIMEHeight * (self.timeArr.count + 2))];
    
    [_backView addSubview:_timeView];
    
    [self.timeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TimeModel *model = (TimeModel *)obj;
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (idx) * TIMEHeight, TITLEWIDTH, TIMEHeight)];
        
        timeLabel.font = [UIFont systemFontOfSize:13.0];
        
        timeLabel.backgroundColor = DEFAULTCOLOR;
        
        timeLabel.textAlignment = NSTextAlignmentCenter;
        
        timeLabel.layer.borderWidth = 1;
        
        timeLabel.layer.borderColor = [UIColor orangeColor].CGColor;
        
        timeLabel.text = model.name;
        
        [_timeView addSubview:timeLabel];
        
    }];
}


- (void) creatContentView {
    if (_contentView) {
        [_contentView removeFromSuperview];
    }
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(TITLEWIDTH, TIMEHeight * 1, (self.meetingArr.count) * TITLEWIDTH, TIMEHeight * (self.timeArr.count))];
    
    [_backView addSubview:_contentView];
    
    [self.meetingArr enumerateObjectsUsingBlock:^(MeetingModel  *meetingModel, NSUInteger meetingIdx, BOOL * _Nonnull stop) {
        
        [self.timeArr enumerateObjectsUsingBlock:^(TimeModel  *timeModel, NSUInteger timeIdx, BOOL * _Nonnull stop) {
            
            [self.contentArr enumerateObjectsUsingBlock:^(MeetingAndReserveModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (obj.x == meetingModel.meetingId && obj.y == timeModel.timeId) {
                    
                    CustomButton *btn = [CustomButton initWithMeetingAndReserve:obj buttonType:UIButtonTypeCustom frame:CGRectMake((meetingIdx) * TITLEWIDTH, (timeIdx ) * TIMEHeight, TITLEWIDTH, TIMEHeight)];
                    
                    btn.delegate = self;
                    
                    [_contentView addSubview:btn];
                    
                } else {
                    
                    CustomButton *btn = [CustomButton initWithMeetingAndReserve:[[MeetingAndReserveModel alloc] initModelWithMeetingX: (int)meetingIdx timeY:(int)timeIdx status: 1] buttonType:UIButtonTypeCustom frame:CGRectMake((meetingIdx) * TITLEWIDTH, (timeIdx) * TIMEHeight, TITLEWIDTH, TIMEHeight)];
                    
                    btn.delegate = self;
                    
                    [_contentView addSubview:btn];
                }
                
            }];
            
        }];
        
    }];
}

/**
 *  处理捏合手势
 *
 *  @param recognizer 捏合手势识别器对象实例
 */
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    
    CGFloat scale = recognizer.scale;
    
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, scale, scale); //在已缩放大小基础下进行累加变化；区别于：使用 CGAffineTransformMakeScale 方法就是在原大小基础下进行变化
    recognizer.scale = 1.0;
    
    self.contentSize = CGSizeMake(self.contentSize.width * scale, self.contentSize.height * scale);
    
    _backView.frame = CGRectMake(0, 0, CGRectGetWidth(_backView.frame), CGRectGetHeight(_backView.frame));
    
    _timeView.transform = CGAffineTransformMakeTranslation((self.contentOffset.x/self.contentSize.width) * (80 * (_meetingArr.count + 1)), 0);
    
    _meetingView.transform = CGAffineTransformMakeTranslation(0 , (self.contentOffset.y/self.contentSize.height) * (30 * (_timeArr.count + 1)));
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (void) getSelectedWithMeetingModel:(MeetingAndReserveModel *) model {
    
    MainData *mainData = [MainData shareMainData];
    
    
    NSLog(@"meetingIden == %d ;;; time == %d",model.x, model.y);
    
    if ([_dateStr isEqualToString:@""] || _dateStr == nil) {
        [Tool getDateWithResult:^(NSArray *arr) {
            
        }];
    }
    
    if ([self.meetingDelegate respondsToSelector:@selector(getReservedMeetingWithArray:)]) {
        [self.meetingDelegate getReservedMeetingWithArray:nil];
    }
}

- (void) cheakSelectedMeetingArr: (MeetingAndReserveModel *) model {
    
}

@end
