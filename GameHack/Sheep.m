#import "Sheep.h"

NSUInteger const SheepPoints = 100;

@implementation Sheep

#pragma mark Object lifecycle
- (id)init
{
  self = [super init];
  if (self) {
    // Load sheep sprite
    self.sprite = [CCSprite spriteWithFile:@"Sheep.png"];
    
    [self addChild:self.sprite];
  }
  return self;
}

#pragma mark Properties
- (NSUInteger)points
{
  return SheepPoints;
}

#pragma mark Cocos2d drawing stuff

//! called once per frame. time a value between 0 and 1
//! For example:
//! * 0 means that the action just started
//! * 0.5 means that the action is in the middle
//! * 1 means that the action is over
-(void) update: (ccTime) time
{
  
}

#pragma mark Touch methods
- (void) wasTouched
{
  // We are no longer interested in touches, stop accepting them
  self.touchEnabled = NO;
  
  // nothing in animal classes, subclasses implement
  NSLog(@"Baaaa, I was touched");
  
  id actionTo = [CCMoveTo actionWithDuration: 2 position: ccp(self.parent.contentSize.width/2, self.parent.contentSize.height/2)];
  id actionCallFunc = [CCCallFunc actionWithTarget:self selector:@selector(wasMovedToPen)];
  
  id actionSequence = [CCSequence actions: actionTo, actionCallFunc, nil];
  
//  [sprite runAction:[CCRepeatForever actionWithAction:action]];
  [self runAction:actionSequence];
  
}

- (void) wasMovedToPen
{
  NSLog(@"Baaa, I'm stuck in a pen");
}


@end
