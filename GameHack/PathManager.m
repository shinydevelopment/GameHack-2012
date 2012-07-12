#import "PathManager.h"

@interface PathManager ()
@property (strong, nonatomic) NSMutableArray *paths;
@end

@implementation PathManager

- (id)init
{
  self = [super init];
  if (self) {
    self.paths = [[[NSMutableArray alloc] init] autorelease];
    [self populateWaypointArrays];
  }
  return self;
}

- (NSArray *)arrayWithWaypoints
{
  NSInteger randomIndex = arc4random() % [self.paths count];
  return self.paths[randomIndex];
}

- (void)populateWaypointArrays
{
  [self.paths addObject:@[
   [NSValue valueWithCGPoint:CGPointMake(87.5, -21.5)],
   [NSValue valueWithCGPoint:CGPointMake(51.5, 100.5)],
   [NSValue valueWithCGPoint:CGPointMake(264.5, 189.5)],
   [NSValue valueWithCGPoint:CGPointMake(237.5, 368.5)],
   [NSValue valueWithCGPoint:CGPointMake(87.5, 446.5)],
   [NSValue valueWithCGPoint:CGPointMake(165.5, 580.5)],
   [NSValue valueWithCGPoint:CGPointMake(282.5, 483.5)],
   [NSValue valueWithCGPoint:CGPointMake(351.5, 693.5)],
   [NSValue valueWithCGPoint:CGPointMake(530.5, 728.5)],
   [NSValue valueWithCGPoint:CGPointMake(490.5, 786.5)]]];
  
  [self.paths addObject:@[
   [NSValue valueWithCGPoint:CGPointMake(43.5, 786.5)],
   [NSValue valueWithCGPoint:CGPointMake(30.5, 665.5)],
   [NSValue valueWithCGPoint:CGPointMake(267.5, 693.5)],
   [NSValue valueWithCGPoint:CGPointMake(223.5, 786.5)]]];
}

#pragma mark Singleton methods
+ (PathManager *)sharedInstance
{
  static dispatch_once_t predicate = 0;
  __strong static id sharedObject = nil;
  dispatch_once(&predicate, ^{ sharedObject = [[self alloc] init]; });
  return sharedObject;
}

@end
