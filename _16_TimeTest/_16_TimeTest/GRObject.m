//
//  GRObject.m
//  _16_TimeTest
//
//  Created by Exo-terminal on 3/28/14.
//  Copyright (c) 2014 Evgenia. All rights reserved.
//

#import "GRObject.h"

@implementation GRObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"GRObject is initialization");
        
        NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTest:) userInfo:nil repeats:YES];
        [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:5]];

    }
    return self;
}
-(void) timerTest:(NSTimer*) timer{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm:ss:SSS"];
    NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
    
//    [timer invalidate];
}


-(void)dealloc{
    NSLog(@"GRObject is deallocated");
}
@end
