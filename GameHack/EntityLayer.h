//
//  EntityLayer.h
//  GameHack
//
//  Created by Oliver Foggin on 12/07/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface EntityLayer : CCLayer

@property (nonatomic) ccTime lastSheepRelease;
@property (nonatomic) double sheepDelay;

- (void)emitSheep;

@end
