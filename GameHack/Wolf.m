#import "Wolf.h"

NSUInteger const WolfPoints = 0;

@implementation Wolf

#pragma mark Object lifecycle
- (id)init
{
  self = [super init];
  if (self) {
    // Load wolf sprite
    //    self.sprite = [CCSprite spriteWithFile:@""];

    // Wolf isn't worth any points
  }
  return self;
}

#pragma mark Properties
- (NSUInteger)points
{
  return WolfPoints;
}

@end
