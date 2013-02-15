//
//  AEMGameResult.h
//  Card
//
//  Created by Arthur Mayes on 2/7/13.
//  Copyright (c) 2013 Arthur Mayes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AEMGameResult : NSObject

+(NSArray *)allGameResults;

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;

@end
