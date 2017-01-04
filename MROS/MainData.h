//
//  MainData.h
//  MROS
//  
//  Created by Sam on 16/12/29.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainData : NSObject

@property (nonatomic, strong) NSMutableArray *selectedMeetingMArray;

+ (instancetype) shareMainData;

@end
