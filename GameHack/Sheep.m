#import "Sheep.h"

NSUInteger const SheepPoints = 100;

@implementation Sheep

#pragma mark Object lifecycle
- (id)init
{
  self = [super init];
  if (self) {
    // Load sheep sprite
    self.sprite = [CCSprite spriteWithFile:@"Icon@2x.png"];
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
  // nothing in animal classes, subclasses implement
  NSLog(@"Baaaa, I was touched");
}


@end
