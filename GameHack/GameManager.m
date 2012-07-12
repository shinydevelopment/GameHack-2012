//
//  GameManager.m
//  GameHack
//
//  Created by Oliver Foggin on 13/07/2012.
//
//

#import "GameManager.h"

@implementation GameManager

- (void)newGame
{
    self.score = 0;
    self.livesLeft = 5;
}

- (void)updateScore:(int)points
{
    self.score += points;
}

- (void)updateLives:(int)livesLost
{
    self.livesLeft -= livesLost;
}

#pragma mark Singleton methods
+ (GameManager *)sharedInstance
{
    static dispatch_once_t predicate = 0;
    __strong static id sharedObject = nil;
    dispatch_once(&predicate, ^{ sharedObject = [[self alloc] init]; });
    return sharedObject;
}

@end