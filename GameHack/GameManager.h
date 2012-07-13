//
//  GameManager.h
//  GameHack
//
//  Created by Oliver Foggin on 13/07/2012.
//
//

#import <Foundation/Foundation.h>

@interface GameManager : NSObject

@property (nonatomic) int score;
@property (nonatomic) int livesLeft;
@property (nonatomic) float difficulty;
@property (nonatomic) BOOL gameOver;

- (void)newGame;

- (void)updateScore:(int)points;
- (void)lostLives:(int)lives;

+ (GameManager *)sharedInstance;

@end
