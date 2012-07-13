#import "Wolf.h"

NSUInteger const WolfPoints = 0;

@implementation Wolf

#pragma mark Object lifecycle
- (id)init
{
  self = [super init];
  if (self) {
    // Load wolf sprite
    self.sprite = [CCSprite spriteWithFile:@"Wolf1.png"];
    self.livesLostOnEscape = 0;
    // Wolf isn't worth any points
  }
  return self;
}

#pragma mark Properties
- (NSUInteger)points
{
  return WolfPoints;
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
  NSLog(@"Wolf, I was touched");
}

@end
