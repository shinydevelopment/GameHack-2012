@interface PathManager : NSObject

- (NSArray *)arrayWithGameWaypoints;
- (NSArray *)arrayWithPaddockWaypoints;

+ (PathManager *)sharedInstance;

@end
