//
//  AHEvent.h
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import <Parse/Parse.h>

typedef NS_ENUM(NSInteger, AHEventType) {
    AHEventTypeHappyHour = 0,
    AHEventTypeSports,
    AHEventTypeCoffee,
    AHEventTypeMeal,
    AHEventTypeMeeting,
    AHEventTypeBirthday
};

@interface AHEvent : PFObject <PFSubclassing>

+ (NSString *)parseClassName;

@end
