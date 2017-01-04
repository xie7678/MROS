//
//  MainData.m
//  MROS
//
//  Created by Sam on 16/12/29.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "MainData.h"

static MainData *mainData = nil;

@implementation MainData


+ (instancetype) shareMainData {
    
    if (!mainData) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            mainData = [[MainData alloc] init];
            
            mainData.selectedMeetingMArray = [NSMutableArray array];
            
        });
    }
    
    return mainData;
    
}



@end
