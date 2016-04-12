//
//  ViewController.m
//  XianchengTest=====线程：手动管理NSthread
//
//  Created by mac on 16/2/26.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //进程：一个应用程序只有一个进程
    //线程：一个进程里面至少包含一个线程（主线程），可以有多个线程
//    for (int i=0; i<1000; i++) {
//        NSLog(@"====%d",i);
//    }
//    NSLog(@"===++++===");
    [self performSelector:@selector(logSomething) withObject:nil afterDelay:2];//延迟方法只是把当前的线程堵塞问题延迟一段时间
    //viewDidLoad==主线程
    
    //遇到可能会堵塞主线程的事件，需要开启分线程处理该事件
    
//纯手动管理的分线程===NSThead===线程调度、线程安全、线程加锁都是自己手动管理
    NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(thread2) object:nil];
    
    [thread start];//减号方法创建的线程不会立即开启线程，要掉start方法来开启
    
    
    
    
    [NSThread detachNewThreadSelector:@selector(thread1) toTarget:self withObject:nil];//加好方法创建的线程会开启分线程，线程立即执行
    
    
    /*
     分线程的特性：
     1.分线程执行一次自动销毁
     2.分线程里面不能刷新UI（原因：如果在分线程里面刷新UI，当前展示的VIew是由主线程所控制的，这个时候会导致刷新UI的效果不同步====要更新ui就要回调主线程刷新UI===[self performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>];）
     
     */
   
    
}

-(void)logSomething{
 NSLog(@"=0===%d",[NSThread isMainThread]);

}
//分线程的开启没有数量的限制
-(void)thread1{

    NSLog(@"=1===%d",[NSThread isMainThread]);
    [NSThread sleepForTimeInterval:3];//线程休眠
 [self performSelectorOnMainThread:@selector(mainThreadLog) withObject:nil waitUntilDone:YES];
}
-(void)mainThreadLog
{
    NSLog(@"mainThreadLog====%d",[NSThread isMainThread]);
}
-(void)thread2{
    
    NSLog(@"=2===%d",[NSThread isMainThread]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
