//
//  EntityLayer.m
//  GameHack
//
//  Created by Oliver Foggin on 12/07/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "EntityLayer.h"
#import "Sheep.h"
#import "Wolf.h"
#import "PathManager.h"

@implementation EntityLayer

- (id)init
{
    self = [super init];
    if (self) {
        _lastSheepRelease = -1;
        _sheepDelay = 3;
        
        [self scheduleUpdate];
    }
    return self;
}

- (void)update:(ccTime)dt
{
    [GameManager sharedInstance].difficulty += dt;
    
    if (_lastSheepRelease < 0) {
        [self emitSheep];
        return;
    }
    
    ccTime timeSinceLastSheep = CACurrentMediaTime() - _lastSheepRelease;
    
    if (timeSinceLastSheep >= self.sheepDelay) {
        [self emitRandomAnimals];
    }
}

- (double)sheepDelay
{
    float difficulty = [GameManager sharedInstance].difficulty;
    
    float max, min;
    
    if (difficulty < 30) {
        max = 10;
        min = 6;
    } else if (difficulty < 60) {
        max = 7;
        min = 3;
    } else if (difficulty < 90) {
        max = 5;
        min = 3;
    } else {
        max = 4;
        min = 2;
    }
    
    double rand = arc4random()%1000/1000.0;
    
    return rand * (max-min) + min;
}

- (void)emitRandomAnimals
{
    float difficulty = [GameManager sharedInstance].difficulty;
    
    float max, min, wolves;
    
    if (difficulty < 10) {
        max = 1;
        min = 1;
        // Let them get comfortable with catching sheep, no wolves at the start.
        // False sense of security. mwhahaha
        wolves = 0;
    } else if (difficulty < 20) {
        max = 2;
        min = 1;
        wolves = 1;
    } else if (difficulty < 35) {
        max = 3;
        min = 1;
        wolves = 2;
    } else {
        max = 4;
        min = 2;
        wolves = 2;
    }
    
    int diff = MAX(1, max - min);
    
    int rand = arc4random()%diff + min;
    
    for (int i=0; i<rand; i++) {
        [self emitSheep];
    }
  
    for (int i=0; i<wolves; i++) {
      [self emitWolf];
    }
}

- (void)emitSheep
{
    _lastSheepRelease = CACurrentMediaTime();
    CCLOG(@"Emit sheep");
    
    NSArray *randomPath = [[PathManager sharedInstance] arrayWithGameWaypoints];
    
    Sheep *mySheep = [[[Sheep alloc] init] autorelease];
    [self addChild:mySheep];
    [mySheep walkPath:randomPath];
}

- (void)emitWolf
{
  CCLOG(@"Emit wolf");
  
  NSArray *randomPath = [[PathManager sharedInstance] arrayWithGameWaypoints];
  
  Wolf *myWolf = [[[Wolf alloc] init] autorelease];
  [self addChild:myWolf];
  [myWolf walkPath:randomPath];
}


@end
