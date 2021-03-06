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
        
        _accessoryLayer = [[AccessoryLayer alloc] init];
        _accessoryLayer.contentSize = size;
        _accessoryLayer.position = self.position;
        [self addChild:_accessoryLayer];
        
        _hudLayer = [[HudLayer alloc] init];
        _hudLayer.contentSize = size;
        _hudLayer.position = self.position;
        [self addChild:_hudLayer];
        
        [[GameManager sharedInstance] newGame];
        
        [[GameManager sharedInstance] addObserver:self forKeyPath:@"gameOver" options:NSKeyValueObservingOptionNew context:NULL];

        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Background.mp3"];
        [SimpleAudioEngine sharedEngine].backgroundMusicVolume = 0.75;
        [SimpleAudioEngine sharedEngine].effectsVolume = 1.0;

      //[[GameManager sharedInstance] newGame];
    }
    return self;
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    [self startScreen];
}

- (void)startScreen
{
    NSLog(@"Start");
    CCSprite *gameOverSprite = [CCSprite spriteWithFile:@"Start.png"];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    gameOverSprite.position = CGPointMake(size.width * 0.5, size.height * 0.5);
    gameOverSprite.scale = 0;
    
    id rotation = [CCRotateBy actionWithDuration:2.0 angle:730];
    id scale = [CCScaleTo actionWithDuration:2.0 scale:2];
    
    id spawnAction = [CCSpawn actionWithArray:@[ rotation, scale ]];
    
    id callBack = [CCCallBlock actionWithBlock:^{
        id shake1 = [CCMoveBy actionWithDuration:0.05 position:ccp(10, 5)];
        id shake2 = [CCMoveBy actionWithDuration:0.05 position:ccp(-5, -10)];
        id shake3 = [CCMoveBy actionWithDuration:0.05 position:ccp(-5, 5)];
        id sequence1 = [CCSequence actionWithArray:@[ shake1, shake2, shake3 ]];
        
        id grow = [CCScaleTo actionWithDuration:0.075 scale:1.05];
        id shrink = [CCScaleTo actionWithDuration:0.075 scale:1];
        id sequence2 = [CCSequence actionWithArray:@[ grow, shrink ]];
        
        id spawnAction = [CCSpawn actionWithArray:@[ sequence1, sequence2 ]];
        
        [self runAction:spawnAction];
        
        self.isTouchEnabled = YES;
    }];
    
    id endSequence = [CCSequence actionWithArray:@[spawnAction, callBack]];
    
    [self.entityLayer removeAllChildrenWithCleanup:YES];
    
    [self.accessoryLayer addChild:gameOverSprite];
    gameOverSprite.tag = 99;
    [gameOverSprite runAction:endSequence];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.accessoryLayer removeChildByTag:99 cleanup:YES];
    
    [[GameManager sharedInstance] newGame];
    
    self.isTouchEnabled = NO;
    
    [_entityLayer scheduleUpdate];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"gameOver"]) {
        if ([change[@"new"] boolValue]) {
            [self gameOver];
        }
    }
}

- (void)gameOver
{
    NSLog(@"GameOver");
    CCSprite *gameOverSprite = [CCSprite spriteWithFile:@"GameOver.png"];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    gameOverSprite.position = CGPointMake(size.width * 0.5, size.height * 0.5);
    gameOverSprite.scale = 0;
    
    id rotation = [CCRotateBy actionWithDuration:0.5 angle:370];
    id scale = [CCScaleTo actionWithDuration:0.5 scale:2];
    
    id spawnAction = [CCSpawn actionWithArray:@[ rotation, scale ]];
    
    id callBack = [CCCallBlock actionWithBlock:^{
        id shake1 = [CCMoveBy actionWithDuration:0.05 position:ccp(10, 5)];
        id shake2 = [CCMoveBy actionWithDuration:0.05 position:ccp(-5, -10)];
        id shake3 = [CCMoveBy actionWithDuration:0.05 position:ccp(-5, 5)];
        id sequence1 = [CCSequence actionWithArray:@[ shake1, shake2, shake3 ]];
        
        id grow = [CCScaleTo actionWithDuration:0.075 scale:1.05];
        id shrink = [CCScaleTo actionWithDuration:0.075 scale:1];
        id sequence2 = [CCSequence actionWithArray:@[ grow, shrink ]];
        
        id spawnAction = [CCSpawn actionWithArray:@[ sequence1, sequence2 ]];
        
        [self runAction:spawnAction];
        
        self.isTouchEnabled = YES;
    }];
    
    id endSequence = [CCSequence actionWithArray:@[spawnAction, callBack]];
    
    [self.entityLayer unscheduleUpdate];
    
    [self.entityLayer removeAllChildrenWithCleanup:YES];
    
    [self.accessoryLayer addChild:gameOverSprite];
    gameOverSprite.tag = 99;
    [gameOverSprite runAction:endSequence];
}

@end
