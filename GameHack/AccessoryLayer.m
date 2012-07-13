//
//  AccessoryLayer.m
//  GameHack
//
//  Created by Oliver Foggin on 13/07/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AccessoryLayer.h"


@implementation AccessoryLayer

- (id)init
{
    self = [super init];
    if (self) {
        CGSize size = self.contentSize;
        
        CCSprite *tree1 = [CCSprite spriteWithFile:@"tree1.png"];
        tree1.position = ccp(size.width * 0.16, size.height * 0.3);
        tree1.scale = 2;
        [self addChild:tree1];
        
        CCSprite *tree2 = [CCSprite spriteWithFile:@"tree2.png"];
        tree2.position = ccp(size.width * 0.8, size.height * 0.75);
        tree2.scale = 2.5;
        [self addChild:tree2];
    }
    return self;
}

@end
