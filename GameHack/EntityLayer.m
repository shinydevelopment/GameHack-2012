//
//  EntityLayer.m
//  GameHack
//
//  Created by Oliver Foggin on 12/07/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "EntityLayer.h"
#import "Sheep.h"

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
    if (_lastSheepRelease < 0) {
        [self emitSheep];
        return;
    }
    
    ccTime timeSinceLastSheep = CACurrentMediaTime() - _lastSheepRelease;
    
    if (timeSinceLastSheep >= _sheepDelay) {
        [self emitSheep];
    }
}

- (void)emitSheep
{
    _lastSheepRelease = CACurrentMediaTime();
    CCLOG(@"Emit sheep");
    
    Sheep *sheep = [[Sheep alloc] init];
    
    
}

@end
