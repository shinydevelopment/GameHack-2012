#import "Animal.h"

@implementation Animal

#pragma mark Object lifecycle
- (id)init
{
  self = [super init];
  if (self) {
    self.startTime = CACurrentMediaTime();
  }
  return self;
}

@end
