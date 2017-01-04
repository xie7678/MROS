//
//  DateModel.h
//  MROS
//
//  Created by Sam on 16/12/27.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateModel : NSObject

@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSString *week;

- (instancetype) initWithDate: (NSString *) date
                         week: (NSString *) week;

@end
