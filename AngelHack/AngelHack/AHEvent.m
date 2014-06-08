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

@end
