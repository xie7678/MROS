//
//  ViewController.h
//  MROS
//
//  Created by Sam on 16/12/26.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "ReserveView.h"


#import "ReserveScrollView.h"

typedef NS_ENUM(NSInteger, DateWeeked) {
    DateWeekedDefault,
    DateWeekedOne,
    DateWeekedTwo,
    DateWeekedTree,
    DateWeekedForce,
    DateWeekedFeve,
    DateWeekedSex
};

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *scrollBackView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *reserveListView;

@property (weak, nonatomic) IBOutlet UIButton *reserveButton;

@property (weak, nonatomic) IBOutlet UIScrollView *weekedScrollView;

@property (nonatomic, assign) DateWeeked dateWeeked;

@property (nonatomic, strong) ReserveScrollView *reserveScrollView;
@end

