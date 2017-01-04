//
//  ViewController.m
//  MROS
//
//  Created by Sam on 16/12/26.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "ViewController.h"
#import "MeetingModel.h"
#import "TimeModel.h"
#import "DateModel.h"
#import "Tool.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ReserveScrollView.h"

#define WEEKEDWIDTH 80
#define WEEKEDHEIGHT 43

@interface ViewController ()<UIScrollViewDelegate>


@property (nonatomic, strong) NSArray *timeNameA;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self creatWeekedScrollView];
    [self creatReserveScrollView];
}

- (void) creatReserveScrollView {
    
    _timeNameA = @[@"9:00~", @"9:30~", @"10:00~", @"10:30~", @"11:00~", @"11:30~", @"12:00~", @"12:30~", @"1:00~", @"1:30~", @"2:00~", @"2:30~", @"3:00~", @"3:30~", @"4:00~", @"4:30~", @"5:00~", @"5:30"];
    
    NSMutableArray *timeMA = [NSMutableArray array];
    
    NSMutableArray *meetingMA = [NSMutableArray array];
    
    for (int i = 0; i < _timeNameA.count; i ++) {
        
        TimeModel *timeModel = [[TimeModel alloc] initModelWithName:_timeNameA[i] Y:i];
        
        [timeMA addObject:timeModel];
        
    }
    
    for (int i = 0; i < 15; i ++) {
        
        MeetingModel *meetmodel = [[MeetingModel alloc] initModelWithName:[NSString stringWithFormat:@"会议室%d",i + 1] X:i];
        
        [meetingMA addObject:meetmodel];
        
    }
    
    MeetingAndReserveModel *model = [[MeetingAndReserveModel alloc] initModelWithMeetingX:0 timeY:0 status:0];
    
    _reserveScrollView = [[ReserveScrollView alloc] initScrollWithMeetingArr:meetingMA timeArr:timeMA contentArr:@[model] frame:self.scrollBackView.bounds];
    
    _reserveScrollView.bounces = NO;
    
    _reserveScrollView.delegate = self;
    
    [self.scrollBackView addSubview:_reserveScrollView];
    
}

#pragma mark - CreatView

- (void) creatWeekedScrollView {
    
    __weak typeof(self) weakSelf = self;
    
    [Tool getDateWithResult:^(NSArray *arr) {
        
        self.weekedScrollView.contentSize = CGSizeMake(WEEKEDWIDTH * arr.count, WEEKEDHEIGHT);
        
        _weekedScrollView.bounces = NO;
        
        _weekedScrollView.showsHorizontalScrollIndicator = NO;
        
        _weekedScrollView.showsVerticalScrollIndicator = NO;
        
        UIView *weekedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.weekedScrollView.contentSize.width, self.weekedScrollView.contentSize.height)];
        
        [self.weekedScrollView addSubview:weekedView];
        
        if (arr.count != 0) {
            
            [arr enumerateObjectsUsingBlock:^(DateModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                
                UIButton *weekedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                
                weekedBtn.tag = idx;
                
                weekedBtn.frame = CGRectMake(WEEKEDWIDTH * idx, 1, WEEKEDWIDTH, WEEKEDHEIGHT);
                
                [weekedBtn setTitle:[NSString stringWithFormat:@"%@\n%@",model.week,model.date] forState:UIControlStateNormal];
                
                [weekedBtn setTitleColor: _dateWeeked != idx ? [UIColor orangeColor] : [UIColor whiteColor] forState:UIControlStateNormal];
                
                weekedBtn.layer.borderWidth = 1;
                
                weekedBtn.layer.borderColor = _dateWeeked != idx ? [UIColor orangeColor].CGColor : [UIColor whiteColor].CGColor;
                
                [weekedBtn setBackgroundColor:_dateWeeked == idx ? [UIColor orangeColor] : [UIColor clearColor]];
                
                weekedBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
                
                weekedBtn.titleLabel.frame = weekedBtn.bounds;
                
                weekedBtn.titleLabel.numberOfLines = 0;
                
                weekedBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
                
                [weekedView addSubview:weekedBtn];
                
                [[weekedBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
                    _dateWeeked = btn.tag;
                    [weakSelf formatDateWeekedBtn];
                }];
                
            }];
        }
    }];
    
}

/**格式化星期按钮*/
- (void) formatDateWeekedBtn {
    for (UIView *view in _weekedScrollView.subviews) {
        for (UIView *btn in view.subviews) {
            if ([btn isKindOfClass:[UIButton class]]) {
                UIButton *dateWB = (UIButton *)btn;
                
                [dateWB setTitleColor: _dateWeeked != dateWB.tag ? [UIColor orangeColor] : [UIColor whiteColor] forState:UIControlStateNormal];
                dateWB.layer.borderColor = _dateWeeked != dateWB.tag ? [UIColor orangeColor].CGColor : [UIColor whiteColor].CGColor;
                
                [dateWB setBackgroundColor:_dateWeeked == dateWB.tag ? [UIColor orangeColor] : [UIColor clearColor]];
            }
        }
    }
}



- (IBAction)showReservedList:(UIButton *)sender {
    
    self.reserveListView.hidden = !self.reserveListView.hidden;
    
    [sender setImage:[UIImage imageNamed: self.reserveListView.hidden ? @"arr-down-icon" : @"arr-up-icon"] forState:UIControlStateNormal];
    
    
}
//用 bounces 属性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ((scrollView.contentOffset.x <= 0)) {
        
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
        
    }else if (scrollView.contentOffset.x + scrollView.frame.size.width >= scrollView.contentSize.width) {
        
        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width - scrollView.frame.size.width, scrollView.contentOffset.y);
        
    }
    
    self.reserveScrollView.meetingView.transform = CGAffineTransformMakeTranslation(0 , (scrollView.contentOffset.y/_reserveScrollView.contentSize.height) * (30 * (_timeNameA.count + 1)));
    
    self.reserveScrollView.timeView.transform = CGAffineTransformMakeTranslation((scrollView.contentOffset.x/_reserveScrollView.contentSize.width) * (80 * 16), 0);
    
}
- (IBAction)sureAction:(UIButton *)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"ReservedListSegue"]) {
//        GroupOutputTableViewController *vc = (GroupOutputTableViewController *)[segue destinationViewController];
//        vc.model = self.modelArray[_selectedRow];
        
        
    }
    
    
    
}

@end
