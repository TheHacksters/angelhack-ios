//
//  AHEvent.m
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>
#import "AHModels.h"
#import "AHEvent.h"

@implementation AHEvent

#pragma mark - Parse
+ (NSString *)parseClassName
{
    return @"Event";
}

#pragma mark - Init
- (AHEvent *)initWithName:(NSString *)name Type:(AHEventType)type Date:(NSDate *)date Location:(NSString *)location andCompany:(AHCompany *)company
{
    AHEvent *response = [[AHEvent alloc] init];
    [response setCreator:[AHUser currentUser]];
    [response setCompany:company];
    [response setName:name];
    [response setType:type];
    [response setDate:date];
    [response setLocation:location];
    
    [response addObject:[AHUser currentUser] forKey:@"confirmed"];
    
    [response save];
    return response;
}

#pragma mark - Setters
- (void)setCompany:(AHCompany *)company
{
    self[@"company"]=company;
}

- (void)setName:(NSString *)name
{
    self[@"name"]=name;
}

- (void)setCreator:(AHUser *)creator
{
    self[@"creator"]=creator;
}

- (void)setType:(AHEventType)type
{
    switch (type) {
        case AHEventTypeHappyHour:
            self[@"type"]= @"happyhour";
            break;
        
        case AHEventTypeSports:
            self[@"type"]= @"sports";
            break;
        
        case AHEventTypeCoffee:
            self[@"type"]= @"coffee";
            break;
            
        case AHEventTypeMeal:
            self[@"type"]= @"meal";
            break;
            
        case AHEventTypeMeeting:
            self[@"type"]= @"meeting";
            break;
            
        case AHEventTypeBirthday:
            self[@"type"]= @"birthday";
            break;
        
        default:
            break;
    }
}

- (void)setDate:(NSDate *)date
{
    self[@"date"]=date;
}

- (void)setLocation:(NSString *)location
{
    self[@"location"]=location;
}

#pragma mark -
- (NSString *)getName
{
    return self[@"name"];
}

- (NSInteger)invitedMembersCount
{
    NSArray *members = (NSArray *)self[@"invited"];
    
    return [members count];
}

- (NSInteger)confirmedMembersCount
{
    NSArray *members = (NSArray *)self[@"confirmed"];
    
    return [members count];
}

- (AHEventType)getType
{
    NSString *type = self[@"type"];
    if ([type isEqualToString:@"coffee"]) {
        return AHEventTypeCoffee;
    }
    if ([type isEqualToString:@"happyhour"]) {
        return AHEventTypeHappyHour;
    }
    if ([type isEqualToString:@"sports"]) {
        return AHEventTypeSports;
    }
    if ([type isEqualToString:@"meeting"]) {
        return AHEventTypeMeeting;
    }
    if ([type isEqualToString:@"meal"]) {
        return AHEventTypeMeal;
    }
    if ([type isEqualToString:@"birthday"]) {
        return AHEventTypeBirthday;
    }
    return -1;
}

- (NSString *)getDateString
{
    NSDate *date = self[@"date"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    //Optionally for time zone converstions
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"BRT"]];
    
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}

@end
