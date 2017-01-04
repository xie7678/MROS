//
//  Tool.m
//  MROS
//
//  Created by Sam on 16/12/27.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "Tool.h"
#import "DateModel.h"
@implementation Tool


+ (int) getDocumentWeekedWithDate: (NSDate *) date {
    
//    NSDate*date = [NSDate date];
    
    NSCalendar*calendar = [NSCalendar currentCalendar];
    
    NSDateComponents*comps;
    
    // 周几和星期几获得
    
    comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
            
                       fromDate:date];
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    
    return (int)weekday;
   
}

+ (void) getDateWithResult: (void (^) (NSArray *arr)) result {
    
    NSInteger dis = 7; //前后的天数
    
    NSDate*nowDate = [NSDate date];
    
    NSDate* theDate;
    
    NSMutableArray *dateMArr = [NSMutableArray array];
    
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    
    
    for (int i = 0; i < dis; i++) {
        theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*i ];
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *currentDateStr = [dateFormatter stringFromDate:theDate];
        
        NSString *weeked = [self getStringWeekWithInt:[self getDocumentWeekedWithDate:theDate]];
        
        DateModel *model = [[DateModel alloc] initWithDate:currentDateStr week:weeked];
        
        
        [dateMArr addObject:model];
        
    }
//    NSLog(@"date == %@", dateMArr);
    result(dateMArr);
}

+ (NSString *) getStringWeekWithInt: (int) week {
    switch (week) {
        case 1:
            return @"周日";
        case 2:
            return @"周一";
        case 3:
            return @"周二";
        case 4:
            return @"周三";
        case 5:
            return @"周四";
        case 6:
            return @"周五";
        case 7:
            return @"周六";
        
        default:
            return @"周日";
    }
}

@end
