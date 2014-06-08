//
//  AHEventInviteViewController.h
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BLADelegate
@optional
- (void)usersArray:(NSArray *)array;
@end

@interface AHEventInviteViewController : UIViewController

@property (weak, nonatomic) id<BLADelegate>delegate;

@end
