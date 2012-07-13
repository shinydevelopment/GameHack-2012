//
//  GameLayer.m
//  GameHack
//
//  Created by Oliver Foggin on 12/07/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@implementation GameLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        _decorationLayer = [[DecorationLayer alloc] init];
        _decorationLayer.contentSize = size;
        _decorationLayer.position = self.position;
        [self addChild:_decorationLayer];
        
        _entityLayer = [[EntityLayer alloc] init];
        _entityLayer.contentSize = size;
        _entityLayer.position = self.position;
        [self addChild:_entityLayer];
        
        _hudLayer = [[HudLayer alloc] init];
        _hudLayer.contentSize = size;
        _hudLayer.position = self.position;
        [self addChild:_hudLayer];
        
        [[GameManager sharedInstance] newGame];
    }
    return self;
}

@end
