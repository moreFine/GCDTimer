//
//  GCDTimer.m
//
//  Created by wangwei on 2018/7/17.
//

#import "GCDTimer.h"

@implementation GCDTimer

-(instancetype)initTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)(void))callback{
    if (self = [super init]){
        _pause = true; //定时器默认暂停
        _duration = 0;
        _interval = interval;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),interval * NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(timer, ^{
            if (callback){
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback();
                });
            }
            self->_duration += interval;
        });
        _timer = timer;
    }
    return self;
}
-(void)setDuration:(double)duration{
    if (_pause){
        //在定时器暂停的情况下才允许设置计时器运行时间
        _duration = duration;
    }
}
-(void)pauseTimer{
    if(self.timer && !_pause){
        dispatch_suspend(self.timer);
        _pause = true;
    }
}
-(void)resumeTimer{
    if(self.timer){
        dispatch_resume(self.timer);
        _pause = false;
    }
}
-(void)stopTimer{
    if(self.timer){
        [self pauseTimer];
        dispatch_source_cancel(self.timer);
    }
}
@end
