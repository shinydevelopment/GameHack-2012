#import "Sheep.h"

NSUInteger const SheepPoints = 100;

@implementation Sheep

#pragma mark Object lifecycle
- (id)init
{
  self = [super init];
  if (self) {
    // Load sheep sprite
  }
  return self;
}

#pragma mark Properties
- (NSUInteger)points
{
  return SheepPoints;
}

@end
