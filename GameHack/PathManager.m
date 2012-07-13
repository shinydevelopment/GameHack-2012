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

- (NSArray *)arrayWithGameWaypoints
{
  NSInteger randomIndex = arc4random() % [self.paths count];
  return self.paths[randomIndex];
}

- (NSArray *)arrayWithPaddockWaypoints
{
  NSInteger randomIndex = arc4random() % [self.paths count];
  return self.paths[randomIndex];
}

- (void)populateWaypointArrays
{
  [self.paths addObject:@[
   [NSValue valueWithCGPoint:CGPointMake(65.5, -111.5)],
   [NSValue valueWithCGPoint:CGPointMake(273.5, 137.5)],
   [NSValue valueWithCGPoint:CGPointMake(65.5, 257.5)],
   [NSValue valueWithCGPoint:CGPointMake(87.5, 352.5)],
   [NSValue valueWithCGPoint:CGPointMake(241.5, 404.5)],
   [NSValue valueWithCGPoint:CGPointMake(296.5, 482.5)],
   [NSValue valueWithCGPoint:CGPointMake(65.5, 560.5)],
   [NSValue valueWithCGPoint:CGPointMake(144.5, 685.5)],
   [NSValue valueWithCGPoint:CGPointMake(457.5, 582.5)],
   [NSValue valueWithCGPoint:CGPointMake(660.5, 711.5)],
   [NSValue valueWithCGPoint:CGPointMake(561.5, 876.5)]]];
  
  [self.paths addObject:@[
   [NSValue valueWithCGPoint:CGPointMake(45.5, 902.5)],
   [NSValue valueWithCGPoint:CGPointMake(141.5, 619.5)],
   [NSValue valueWithCGPoint:CGPointMake(318.5, 697.5)],
   [NSValue valueWithCGPoint:CGPointMake(491.5, 658.5)],
   [NSValue valueWithCGPoint:CGPointMake(556.5, 902.5)],
   [NSValue valueWithCGPoint:CGPointMake(45.5, 902.5)]]];
  
  [self.paths addObject:@[
   [NSValue valueWithCGPoint:CGPointMake(1156.5, 626.5)],
   [NSValue valueWithCGPoint:CGPointMake(834.5, 535.5)],
   [NSValue valueWithCGPoint:CGPointMake(748.5, 700.5)],
   [NSValue valueWithCGPoint:CGPointMake(431.5, 657.5)],
   [NSValue valueWithCGPoint:CGPointMake(576.5, 562.5)],
   [NSValue valueWithCGPoint:CGPointMake(912.5, 723.5)],
   [NSValue valueWithCGPoint:CGPointMake(773.5, 888.5)]]];
  
  [self.paths addObject:@[
   [NSValue valueWithCGPoint:CGPointMake(1170.5, 427.5)],
   [NSValue valueWithCGPoint:CGPointMake(850.5, 612.5)],
   [NSValue valueWithCGPoint:CGPointMake(631.5, 644.5)],
   [NSValue valueWithCGPoint:CGPointMake(557.5, 590.5)],
   [NSValue valueWithCGPoint:CGPointMake(812.5, 468.5)],
   [NSValue valueWithCGPoint:CGPointMake(727.5, 234.5)],
   [NSValue valueWithCGPoint:CGPointMake(463.5, 148.5)],
   [NSValue valueWithCGPoint:CGPointMake(557.5, 60.5)],
   [NSValue valueWithCGPoint:CGPointMake(444.5, -129.5)]]];
  
  [self.paths addObject:@[
   [NSValue valueWithCGPoint:CGPointMake(643.5, -135.5)],
   [NSValue valueWithCGPoint:CGPointMake(781.5, 109.5)],
   [NSValue valueWithCGPoint:CGPointMake(381.5, 207.5)],
   [NSValue valueWithCGPoint:CGPointMake(521.5, -135.5)]]];
  
  [self.paths addObject:@[
   [NSValue valueWithCGPoint:CGPointMake(1159.5, 334.5)],
   [NSValue valueWithCGPoint:CGPointMake(851.5, 254.5)],
   [NSValue valueWithCGPoint:CGPointMake(739.5, 537.5)],
   [NSValue valueWithCGPoint:CGPointMake(898.5, 652.5)],
   [NSValue valueWithCGPoint:CGPointMake(337.5, 593.5)],
   [NSValue valueWithCGPoint:CGPointMake(212.5, 734.5)],
   [NSValue valueWithCGPoint:CGPointMake(321.5, 918.5)]]];
  
  [self.paths addObject:@[
   [NSValue valueWithCGPoint:CGPointMake(781.5, -174.5)],
   [NSValue valueWithCGPoint:CGPointMake(888.5, 114.5)],
   [NSValue valueWithCGPoint:CGPointMake(744.5, 210.5)],
   [NSValue valueWithCGPoint:CGPointMake(860.5, 361.5)],
   [NSValue valueWithCGPoint:CGPointMake(723.5, 475.5)],
   [NSValue valueWithCGPoint:CGPointMake(937.5, 621.5)],
   [NSValue valueWithCGPoint:CGPointMake(698.5, 725.5)],
   [NSValue valueWithCGPoint:CGPointMake(799.5, 920.5)]]];
  
  [self.paths addObject:@[
   [NSValue valueWithCGPoint:CGPointMake(-168.5, 33.5)],
   [NSValue valueWithCGPoint:CGPointMake(152.5, 151.5)],
   [NSValue valueWithCGPoint:CGPointMake(177.5, 445.5)],
   [NSValue valueWithCGPoint:CGPointMake(-168.5, 353.5)]]];
  
  [self.paths addObject:@[
   [NSValue valueWithCGPoint:CGPointMake(-133.5, 611.5)],
   [NSValue valueWithCGPoint:CGPointMake(113.5, 487.5)],
   [NSValue valueWithCGPoint:CGPointMake(216.5, 547.5)],
   [NSValue valueWithCGPoint:CGPointMake(201.5, 703.5)],
   [NSValue valueWithCGPoint:CGPointMake(69.5, 664.5)],
   [NSValue valueWithCGPoint:CGPointMake(201.5, 454.5)],
   [NSValue valueWithCGPoint:CGPointMake(216.5, 271.5)],
   [NSValue valueWithCGPoint:CGPointMake(347.5, 127.5)],
   [NSValue valueWithCGPoint:CGPointMake(253.5, 28.5)],
   [NSValue valueWithCGPoint:CGPointMake(238.5, -201.5)]]];
  
  
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
