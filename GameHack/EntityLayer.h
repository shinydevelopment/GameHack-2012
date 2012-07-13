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
@property (nonatomic) ccTime lastWolfRelease;
@property (nonatomic) ccTime lastGoldenSheepRelease;
@property (nonatomic) double sheepDelay;
@property (nonatomic) double wolfDelay;
@property (nonatomic) double goldenSheepDelay;


- (void)emitWolf;
- (void)emitSheep;
- (void)emitGoldenSheep;
- (void)emitRandomNumberOfSheep;

@end
