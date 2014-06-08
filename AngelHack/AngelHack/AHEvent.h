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

- (AHEvent *)initWithName:(NSString *)name Type:(AHEventType)type Date:(NSDate *)date Location:(NSString *)location andCompany:(AHCompany *)company;
- (void)setCompany:(AHCompany *)company;
- (void)setName:(NSString *)name;
- (void)setCreator:(AHUser *)creator;
- (void)setType:(AHEventType)type;
- (void)setDate:(NSDate *)date;
- (void)setLocation:(NSString *)location;
@end
