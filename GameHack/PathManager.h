@interface PathManager : NSObject

- (NSArray *)arrayWithWaypoints;

+ (PathManager *)sharedInstance;

@end
