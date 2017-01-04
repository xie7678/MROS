//
//  TimeModel.h
//  MROS
//
//  Created by Sam on 16/12/26.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) int timeId;

- (instancetype) initModelWithName: (NSString *) name Y: (int) y;

@end
