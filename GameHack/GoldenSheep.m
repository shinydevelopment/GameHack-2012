//
//  GoldenSheep.m
//  GameHack
//
//  Created by Oliver Foggin on 13/07/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GoldenSheep.h"

NSUInteger const GoldenSheepPoints = 500;

@implementation GoldenSheep

#pragma mark Object lifecycle
- (id)init
{
    self = [super init];
    if (self) {
        // Load sheep sprite
        self.sprite = [CCSprite spriteWithFile:@"Golden-Sheep.png"];
        self.livesLostOnEscape = 0;
        [self addChild:self.sprite];
    }
    return self;
}

#pragma mark Properties
- (NSUInteger)points
{
    return GoldenSheepPoints;
}

- (void)animateLabelWithScore:(int)score
{
    __block CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", score] fontName:@"Marker Felt" fontSize:32];
    [label setColor:ccc3(255, 255, 0)];
    label.position = self.position;
    label.scale = 0;
    
    id transform = [CCMoveBy actionWithDuration:0.3 position:ccp(0, 10)];
    id scale = [CCScaleTo actionWithDuration:0.5 scale:2];
    
    id spawn = [CCSpawn actionWithArray:@[ transform, scale ]];
    
    id fade = [CCFadeOut actionWithDuration:0.2];
    
    id callBlock = [CCCallBlock actionWithBlock:^{
        [label removeFromParentAndCleanup:YES];
    }];
    
    id sequence = [CCSequence actionWithArray:@[spawn, fade, callBlock]];
    
    [self.parent addChild:label];
    [label runAction:sequence];
}

- (void)emitParticles
{
    CCParticleSystemQuad *emitter = [CCParticleSystemQuad particleWithFile:@"explosionEmitter.plist"];
    emitter.position = self.position;
    [self.parent addChild:emitter];
}

#pragma mark Touch methods
- (void) wasTouched
{
    [super wasTouched];
    
    [self emitParticles];
    
    // nothing in animal classes, subclasses implement
    NSLog(@"Baaaa, I was touched");
    [[GameManager sharedInstance] updateScore:self.points];
    [[GameManager sharedInstance] lostLives:-1];
    
    [self animateLabelWithScore:self.points];
    
    [self removeFromParentAndCleanup:YES];
}

@end
