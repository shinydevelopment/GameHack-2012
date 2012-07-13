#import "Animal.h"

@interface Sheep : Animal

+ (void)cullSheepInLayer:(CCLayer *)layer;
+ (NSMutableArray *)sheepInPenInlayer:(CCLayer *)layer;
+ (void)cullSheepInPenInLayer:(CCLayer *)layer;
- (void)cull;

@end
