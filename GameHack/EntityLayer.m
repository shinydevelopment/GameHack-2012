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
#import "GoldenSheep.h"
#import "PathManager.h"

@implementation EntityLayer

- (id)init
{
    self = [super init];
    if (self) {
        _lastSheepRelease = -1;
        _sheepDelay = 3;
        _goldenSheepDelay = 15;
        // Don't release in first 10 seconds
        _lastGoldenSheepRelease = CACurrentMediaTime() + 10;
        _lastWolfRelease = CACurrentMediaTime() + 10;
        
        [self scheduleUpdate];
      
        id cullSheepAction = [CCCallBlock actionWithBlock:^{
          [Sheep cullSheepInLayer:self];
        }];
        id delayAction = [CCDelayTime actionWithDuration:2.0];
      
        id sequence = [CCSequence actionWithArray:@[cullSheepAction, delayAction]];
      
        [self runAction:[CCRepeatForever actionWithAction:sequence]];
      
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
        [self emitRandomNumberOfSheep];
    }
    
    ccTime timeSinceLastGoldenSheep = CACurrentMediaTime() - self.lastGoldenSheepRelease;
    if (timeSinceLastGoldenSheep >= self.goldenSheepDelay) {
        [self emitGoldenSheep];
    }
  
    ccTime timeSinceLastWolf = CACurrentMediaTime() - self.lastWolfRelease;
    if (timeSinceLastWolf >= self.wolfDelay) {
      [self emitWolf];
    }

}

- (double)wolfDelay
{
  // Let them get comfortable with catching sheep, no wolves at the start.
  // False sense of security. mwhahaha
  float difficulty = [GameManager sharedInstance].difficulty;
  
  float max, min;
  
  if (difficulty < 30) {
    max = 20;
    min = 10;
  } else if (difficulty < 60) {
    max = 15;
    min = 7;
  } else if (difficulty < 90) {
    max = 8;
    min = 3;
  } else {
    max = 4;
    min = 2;
  }
  
  double rand = arc4random()%1000/1000.0;
  
  return rand * (max-min) + min;
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

- (void)emitRandomNumberOfSheep
{
    float difficulty = [GameManager sharedInstance].difficulty;
    
    float max, min;
    
    if (difficulty < 10) {
        max = 1;
        min = 1;
    } else if (difficulty < 20) {
        max = 2;
        min = 1;
    } else if (difficulty < 35) {
        max = 3;
        min = 1;
    } else {
        max = 4;
        min = 2;
    }
    
    int diff = MAX(1, max - min);
    
    int rand = arc4random()%diff + min;
    
    for (int i=0; i<rand; i++) {
        [self emitSheep];
    }
}

- (void)emitGoldenSheep
{
    self.lastGoldenSheepRelease = CACurrentMediaTime();
    CCLOG(@"Emit GOLDEN SHEEP!");
    
    NSArray *randomPath = [[PathManager sharedInstance] arrayWithGameWaypoints];
    
    GoldenSheep *mySheep = [[[GoldenSheep alloc] init] autorelease];
    [self addChild:mySheep];
    [mySheep walkPath:randomPath];
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
  _lastWolfRelease = CACurrentMediaTime();
  CCLOG(@"Emit wolf");
  
  NSArray *randomPath = [[PathManager sharedInstance] arrayWithGameWaypoints];
  
  Wolf *myWolf = [[[Wolf alloc] init] autorelease];
  [self addChild:myWolf];
  [myWolf walkPath:randomPath];
}


@end
