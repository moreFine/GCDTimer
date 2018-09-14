//
//  GCDTimer.h
//
//  Created by wangwei on 2018/7/17.
//

#import <Foundation/Foundation.h>

@interface GCDTimer : NSObject
@property (nonatomic, assign, readonly, getter = isPause) BOOL pause;  //停止：true 运行：false
@property (nonatomic, assign, readonly) double interval;               //定时器间隙,单位:秒(s)
@property (nonatomic, assign) double    duration;                      //运行时间,单位:秒(s)
@property (nonatomic, strong) dispatch_source_t timer;
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)(void)) callback;
-(void)pauseTimer;
-(void)resumeTimer;
-(void)stopTimer;
@end
