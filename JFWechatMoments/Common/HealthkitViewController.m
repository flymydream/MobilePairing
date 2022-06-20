//
//  HealthkitViewController.m
//  JFWechatMoments
//
//  Created by hero on 2022/3/10.
//  Copyright © 2022 fanzhiying. All rights reserved.
//

#import "HealthkitViewController.h"
#import<HealthKit/HealthKit.h>
#import<CoreMotion/CoreMotion.h>

@interface HealthkitViewController ()
{
    HKHealthStore  *store;
}
 
@property (nonatomic, strong) NSMutableArray *healthSteps;//步数
@property (nonatomic, strong) NSMutableArray *healthCalories;//卡路里
@property (nonatomic, strong) NSMutableArray *healthDistances;//距离

@end

@implementation HealthkitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.healthSteps = [NSMutableArray array];
        self.healthDistances = [NSMutableArray array];
        self.healthCalories = [NSMutableArray array];
        
        NSSet *getData;
        
        // 1.判断设备是否支持HealthKit框架
        if ([HKHealthStore isHealthDataAvailable]) {
            
            getData = [self getData];
            
        } else {
            NSLog(@"---------不支持 HealthKit 框架");
        }
        
        store = [[HKHealthStore alloc] init];
        
        // 2.请求苹果健康的认证
        [store requestAuthorizationToShareTypes:nil readTypes:getData completion:^(BOOL success, NSError * _Nullable error) {
            if (!success) {
                NSLog(@"--------请求苹果健康认证失败");
                
                return ;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 3.获取苹果健康数据
                [self getHealthStepData];
                [self getHealthDistanceData];
            });
            
        }];
}
//设置好要获取的数据类型
- (NSSet *)getData{
    HKQuantityType  *step = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    HKQuantityType *distance = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    return [NSSet setWithObjects:step,distance, nil];
}
- (void)updateStep{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *now = [NSDate date];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    
    NSDate *startDate = [calendar dateFromComponents:components];
    
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    
    HKQuantityType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:sampleType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        //        if (!result) {
        //            if (completionHandler) {
        //                completionHandler(0.0f, error);
        //            }
        //            return;
        //        }
        
        double totalStep = [result.sumQuantity doubleValueForUnit:[HKUnit countUnit]];
        NSLog(@" ***************步数统计是：%f",totalStep);
    }];
    
    [store executeQuery:query];
    
}

- (void)updateDistance{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *now = [NSDate date];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    
    NSDate *startDate = [calendar dateFromComponents:components];
    
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    
    HKQuantityType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:sampleType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        //        if (!result) {
        //            if (completionHandler) {
        //                completionHandler(0.0f, error);
        //            }
        //            return;
        //        }
        
        double totalStep = [result.sumQuantity doubleValueForUnit:[HKUnit meterUnit]];
        NSLog(@" -------------距离统计是：%f",totalStep);
    }];
    
    [store executeQuery:query];
}

- (void)updateEnergy{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *now = [NSDate date];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    
    NSDate *startDate = [calendar dateFromComponents:components];
    
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    
    HKQuantityType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:sampleType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        //        if (!result) {
        //            if (completionHandler) {
        //                completionHandler(0.0f, error);
        //            }
        //            return;
        //        }
        
        double totalStep = [result.sumQuantity doubleValueForUnit:[HKUnit calorieUnit]];
        NSLog(@" -------------卡路里统计是：%f",totalStep);
    }];
    
    [store executeQuery:query];
}

//获取步数代码
- (void)getHealthStepData{
    HKHealthStore *healthStore = [[HKHealthStore alloc]init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 设置时间支持单位
    NSDateComponents *anchorComponents =
    [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth |
     NSCalendarUnitYear | NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
    
    // 获取数据的截止时间 今天
    NSDate *endDate = [NSDate date];
    // 获取数据的起始时间 此处取从今日往前推100天的数据
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:-100*24*60*60];
    
    // 数据类型
    HKQuantityType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    // Your interval: sum by hour
    NSDateComponents *intervalComponents = [[NSDateComponents alloc] init];
    intervalComponents.day = 1;
    
    // Example predicate 用于获取设置时间段内的数据
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    
    
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:type quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum anchorDate:anchorDate intervalComponents:intervalComponents];
    
    
    query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *result, NSError *error) {
        
        for (HKStatistics *sample in [result statistics]) {
            //            NSLog(@"--------------%@ 至 %@ : %@", sample.startDate, sample.endDate, sample.sumQuantity);
            NSDate *date = sample.endDate;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateTime = [formatter stringFromDate:date];
            
            double totalStep = [sample.sumQuantity doubleValueForUnit:[HKUnit countUnit]];
            NSString *appleHealth = @"com.apple.Health";
            
            double editStep  = 0.0;
            for (HKSource *source in sample.sources) {
                
                if ([source.bundleIdentifier isEqualToString:appleHealth]) {
                    // 获取用户自己添加的数据 并减去，防止用户手动刷数据
                    HKSource *healthSource = source;
                    editStep  = [[sample sumQuantityForSource:healthSource] doubleValueForUnit:[HKUnit countUnit]];
                }
            }
            
            NSInteger step = (NSInteger)totalStep - (NSInteger)editStep;
            
            NSString *value = [NSString stringWithFormat:@"%ld",step];
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 dateTime,@"dateTime",
                                 value,@"value",nil];
            [self.healthSteps addObject:dic];
            //            NSLog(@"gaizaoDateStyle:%@  Dic = %@",self.healthSteps,dic);
        }
        self.healthCalories = self.healthSteps;
        
        NSDictionary *healthSteps = [NSDictionary dictionaryWithObjectsAndKeys:
                                     self.healthSteps,@"healthSteps",
                                     self.healthCalories,@"healthCalories",nil];
        NSLog(@"改造数据格式：%@",healthSteps);
        
    };
    
    [healthStore executeQuery:query];
   
   [CMPedometer isStepCountingAvailable];

}
//获取距离代码
- (void)getHealthDistanceData{
    HKHealthStore *healthStore = [[HKHealthStore alloc]init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *anchorComponents =
    [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth |
     NSCalendarUnitYear | NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
    
    NSDate *endDate = [NSDate date];
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:-100*24*60*60];
    
    HKQuantityType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    // Your interval: sum by hour
    NSDateComponents *intervalComponents = [[NSDateComponents alloc] init];
    intervalComponents.day = 1;
    
    // Example predicate
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:type quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum anchorDate:anchorDate intervalComponents:intervalComponents];
    query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *result, NSError *error) {
        for (HKStatistics *sample in [result statistics]) {
            //            NSLog(@"+++++++++++++++%@ 至 %@ : %@", sample.startDate, sample.endDate, sample.sumQuantity);
            NSDate *date = sample.endDate;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateTime = [formatter stringFromDate:date];
            
            double totalDistance = [sample.sumQuantity doubleValueForUnit:[HKUnit meterUnit]];
            
            NSString *appleHealth = @"com.apple.Health";
            //            double floor = [sample.sumQuantity doubleValueForUnit:[HKUnit yardUnit]];
            double editDistance  = 0.0;
            for (HKSource *source in sample.sources) {
                if ([source.bundleIdentifier isEqualToString:appleHealth]) {
                    // 获取用户自己添加的数据 并减去，防止用户手动刷数据
                    HKSource *healthSource = source;
                    editDistance = [[sample sumQuantityForSource:healthSource] doubleValueForUnit:[HKUnit meterUnit]];
                }
            }
            
            double distance = totalDistance/1000 - editDistance/1000;
            
            NSString *value = [NSString stringWithFormat:@"%f",distance];
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 dateTime,@"dateTime",
                                 value,@"value",nil];
            [self.healthDistances addObject:dic];
        }
        
        NSLog(@"改造距离格式：%@",self.healthDistances);
    };
    
    [healthStore executeQuery:query];

}


//dispatch_group_t group = dispatch_group_create();
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //请求1
//        NSLog(@"Request_1");
//    });
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //请求2
//        NSLog(@"Request_2");
//    });
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //请求3
//        NSLog(@"Request_3");
//    });
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        //界面刷新
//        NSLog(@"任务均完成，刷新界面");
//    });



//dispatch_group_t group = dispatch_group_create();
//    dispatch_group_enter(group);
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //请求1
//        [网络请求:{
//        成功：dispatch_group_leave(group);
//        失败：dispatch_group_leave(group);
//}];
//    });
//    dispatch_group_enter;
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //请求2
//        [网络请求:{
//        成功：dispatch_group_leave;
//        失败：dispatch_group_leave;
//}];
//    });
//    dispatch_group_enter(group);
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //请求3
//        [网络请求:{
//        成功：dispatch_group_leave(group);
//        失败：dispatch_group_leave(group);
//}];
//    });
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        //界面刷新
//        NSLog(@"任务均完成，刷新界面");
//    });
//dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

//二、某界面存在多个请求，希望请求依次执行。
//对于这个问题通常会通过线程依赖进行解决，因使用GCD设置线程依赖比较繁琐，这里通过NSOperationQueue进行实现，这里采用比较经典的例子，三个任务分别为下载图片，打水印和上传图片，三个任务需异步执行但需要顺序性。代码如下，下载图片、打水印、上传图片仍模拟为分别请求新闻列表3页数据。
//
////1.任务一：下载图片
//  NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
//      [self request_A];
//  }];
//
//  //2.任务二：打水印
//  NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
//      [self request_B];
//  }];
//
//  //3.任务三：上传图片
//  NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
//      [self request_C];
//  }];
//
//  //4.设置依赖
//  [operation2 addDependency:operation1];      //任务二依赖任务一
//  [operation3 addDependency:operation2];      //任务三依赖任务二
//
//  //5.创建队列并加入任务
//  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//  [queue addOperations:@[operation3, operation2, operation1] waitUntilFinished:NO];



//dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//[网络请求:{
//        成功：dispatch_semaphore_signal(sema);
//        失败：dispatch_semaphore_signal(sema);
//}];
//dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);


//获取步数
//- (void)getStepCount:(void(^)(double value, NSError *error))completion{
//    //HKQuantityTypeIdentifierStepCount 计算步数
//    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
//    //排序规则
//    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
//    //HKObjectQueryNoLimit 数量限制
//    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:stepType predicate:[HealthKitManage predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
//        if(error)
//        {
//            completion(0,error);
//        }
//        else
//        {
//            NSInteger totleSteps = 0;
//            double sumTime = 0;
//            //获取数组
//            for(HKQuantitySample *quantitySample in results){
//                HKQuantity *quantity = quantitySample.quantity;
//                HKUnit *heightUnit = [HKUnit countUnit];
//                double usersHeight = [quantity doubleValueForUnit:heightUnit];
//                NSLog(@"%f",usersHeight);
//                totleSteps += usersHeight;
//
//                NSDateFormatter *fm=[[NSDateFormatter alloc]init];
//                fm.dateFormat=@"yyyy-MM-dd HH:mm:ss";
//                NSString *strNeedStart = [fm stringFromDate:quantitySample.startDate];
//                NSLog(@"startDate %@",strNeedStart);
//                NSString *strNeedEnd = [fm stringFromDate:quantitySample.endDate];
//                NSLog(@"endDate %@",strNeedEnd);
//                sumTime += [quantitySample.endDate timeIntervalSinceDate:quantitySample.startDate];
//            }
//            NSLog(@"当天行走步数 = %ld",(long)totleSteps);
//            int h = sumTime / 3600;
//            int m = ((long)sumTime % 3600)/60;
//            NSLog(@"运动时长：%@小时%@分", @(h), @(m));
//            completion(totleSteps,error);
//        }
//    }];
//
//    [self.healthStore executeQuery:query];
//}


//获取公里数
//- (void)getDistance:(void(^)(double value, NSError *error))completion
//{
//    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
//    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
//    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:distanceType predicate:[HealthKitManage predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
//
//        if(error)
//        {
//            completion(0,error);
//        }
//        else
//        {
//            double totleSteps = 0;
//            for(HKQuantitySample *quantitySample in results)
//            {
//                HKQuantity *quantity = quantitySample.quantity;
//                HKUnit *distanceUnit = [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixKilo];
//                double usersHeight = [quantity doubleValueForUnit:distanceUnit];
//                totleSteps += usersHeight;
//            }
//            NSLog(@"当天行走距离 = %.2f",totleSteps);
//            completion(totleSteps,error);
//        }
//    }];
//    [self.healthStore executeQuery:query];
//}

//// 查询数据的类型，比如计步，行走+跑步距离等等
//HKQuantityType *quantityType = [HKQuantityType quantityTypeForIdentifier:(HKQuantityTypeIdentifierStepCount)];
//// 谓词，用于限制查询返回结果
//NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:start endDate:end options:(HKQueryOptionNone)];
//
//NSCalendar *calendar = [NSCalendar currentCalendar];
//NSDateComponents *anchorComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
//// 用于锚集合的时间间隔
//NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
//
//// 采样时间间隔
//NSDateComponents *intervalComponents = [[NSDateComponents alloc] init];
//intervalComponents.day = 1;
//
//// 创建统计查询对象
//HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:predicate options:(HKStatisticsOptionCumulativeSum|HKStatisticsOptionSeparateBySource) anchorDate:anchorDate intervalComponents:intervalComponents];
//query.initialResultsHandler = ^(HKStatisticsCollectionQuery * _Nonnull query, HKStatisticsCollection * _Nullable result, NSError * _Nullable error) {
//NSMutableArray *resultArr =  [NSMutableArray array];
//if (error) {
//    NSLog(@"error: %@", error);
//} else {
//    for (HKStatistics *statistics in [result statistics]) {
//        NSLog(@"statics: %@,\n sources: %@", statistics, statistics.sources);
//        for (HKSource *source in statistics.sources) {
//            // 过滤掉其它应用写入的健康数据
//            if ([source.name isEqualToString:[UIDevice currentDevice].name]) {
//            // 获取到步数
//            double step = round([[statistics sumQuantityForSource:source] doubleValueForUnit:[HKUnit countUnit]]);
//            }
//        }
//    }
//}
//// 执行查询请求
//[self.healthStore executeQuery:query];
 
/*!
 *  @brief  当天时间段
 *
 *  @return 时间段
 */
+ (NSPredicate *)predicateForSamplesToday {
    //获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获取当前时间
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:now];
    //设置为0
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    //设为开始时间
    NSDate *startDate = [calendar dateFromComponents:components];
    //把开始时间之后推一天为结束时间
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    //设置开始时间和结束时间为一段时间
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    return predicate;
}
//https://www.cnblogs.com/demodashi/p/8509492.html


//- (void)hidesTabBar:(BOOL)hidden{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0];
//    for (UIView *view in self.tabBarController.view.subviews) {
//        if ([view isKindOfClass:[UITabBar class]]) {
//            if (hidden) {
//                [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width , view.frame.size.height)];
//
//            }else{
//                [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height - 49, view.frame.size.width, view.frame.size.height)];
//
//            }
//        }else{
//            if([view isKindOfClass:NSClassFromString(@"UITransitionView")]){
//                if (hidden) {
//                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
//
//                }else{
//                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 49 )];
//
//                }
//            }
//        }
//    }
//    [UIView commitAnimations];
//
//}

//1
#pragma mark -隐藏TabBar
- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}

#pragma mark -显示TabBar
- (void)showTabBar {
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}

//2
////隐藏
//self.hidesBottomBarWhenPushed = YES;
////显示
//self.hidesBottomBarWhenPushed = NO;


//vc.hidesBottomBarWhenPushed = YES;
//[self.navigationController pushViewController:vc animated:YES];


// 强制显示tabbar
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
//     // 强制显示tabbar
//     NSArray *views = self.tabBarController.view.subviews;
//     UIView *contentView = [views objectAtIndex:0];
//     contentView.height -= 49;
//     self.tabBarController.tabBar.hidden = NO;
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    // 强制隐藏tabbar
//    NSArray *views = self.tabBarController.view.subviews;
//    UIView *contentView = [views objectAtIndex:0];
//    contentView.height += 49;
//    self.tabBarController.tabBar.hidden = YES;
//}


#pragma mark - 获取当天的步数
//- (NSPredicate *)predicateForSamplesToday {
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//
//    NSDate *now = [NSDate date];
//
//    NSDate *startDate = [calendar startOfDayForDate:now];
//    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
//
//    return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
//}

//- (NSPredicate *)getPredict {
//   NSDate *now = [NSDate date];
//       NSCalendar *calender = [NSCalendar currentCalendar];
//       NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//       NSDateComponents *dateComponent = [calender components:unitFlags fromDate:now];
//       int hour = (int)[dateComponent hour];
//       int minute = (int)[dateComponent minute];
//       int second = (int)[dateComponent second];
//       NSDate *nowDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second) ];
//       //时间结果与想象中不同是因为它显示的是0区
//       NSLog(@"今天%@",nowDay);
//       NSDate *nextDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second)  + 86400];
//       NSLog(@"明天%@",nextDay);
//       NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:nowDay endDate:nextDay options:(HKQueryOptionNone)];
//   return predicate;
//}


//iOS7
//
//zh-Hans: 简体
//zh-Hant: 繁体
//
//iOS8
//
//zh-Hans: 简体
//zh-Hant: 繁体
//zh-HK: 香港繁体（增加）
//
//iOS9
//
//zh-Hans-CN: 简体（改变）
//zh-Hant-CN: 繁体（改变）
//zh-HK: 香港繁体
//zh-TW: 台湾繁体（增加）
//
//iOS 10
//
//zh-Hans-CN 简体
//yue-Hans-CN 粤语 简体 （增加）
//yue-Hant-CN 粤语 繁体 （增加）
//zh-Hant-CN 繁体
//zh-Hant-MO 澳门繁体 （改变）
//zh-Hant-TW 台湾繁体 （改变）
//zh-Hant-HK 香港繁体 （改变）


- (BOOL)isChineseLanguage {
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *pfLanguageCode = [languages objectAtIndex:0];
    if ([pfLanguageCode isEqualToString:@"zh-Hant"] ||
        [pfLanguageCode hasPrefix:@"zh-Hant"] ||
        [pfLanguageCode hasPrefix:@"yue-Hant"] ||
        [pfLanguageCode isEqualToString:@"zh-HK"] ||
        [pfLanguageCode isEqualToString:@"zh-TW"]||
        [pfLanguageCode isEqualToString:@"zh-Hans"] ||
        [pfLanguageCode hasPrefix:@"yue-Hans"] ||
        [pfLanguageCode hasPrefix:@"zh-Hans"]
        ){
        return YES;
    } else {
        return NO;
    }
    return NO;
}
 
- (void)setLanguage {
   //或者这个方法，NSUserDefaults可以强制写入首选语言用于应用内切换语言 获取系统当前语言版本(中文zh-Hans,英文en)
   NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
   NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
   NSString * preferredLang = [allLanguages objectAtIndex:0];
}

//判断是否安装app
//+ (BOOL)verifyAppWithBundle:(NSString *)bundleID{
//  __block BOOL isInstall = NO;
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0) {
//                 //iOS12间接获取办法
//           if ([[UIDevice currentDevice].systemVersion floatValue] >= 12.0){
//                    Class lsawsc = objc_getClass("LSApplicationWorkspace");
//                    NSObject* workspace = [lsawsc performSelector:NSSelectorFromString(@"defaultWorkspace")];
//                    NSArray *plugins = [workspace performSelector:NSSelectorFromString(@"installedPlugins")]; //列出所有plugins
////                    DLOG(@"installedPlugins:%@",plugins);
//                    [plugins enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    NSString *pluginID = [obj performSelector:(@selector(pluginIdentifier))];
//                        NSLog(@"pluginID：%@",pluginID);
//                        if([pluginID containsString:bundleID]){
//                            isInstall = YES;
//                            return;
//                        }
//               }];
//               return isInstall;
//           }else{
//                   //iOS11获取办法
//                   NSBundle *container = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/MobileContainerManager.framework"];
//                   if ([container load]) {
//                         Class appContainer = NSClassFromString(@"MCMAppContainer");
//                         id test = [appContainer performSelector:@selector(containerWithIdentifier:error:) withObject:bundleID withObject:nil];
//                         NSLog(@"%@",test);
//                         if (test) {
//                              return YES;
//                          } else {
//                              return NO;
//                            }
//
//                    }else{
//                        return NO;
//                    }
//
//               }
//
//       }else{
//       //iOS10及以下获取办法
//           Class lsawsc = objc_getClass("LSApplicationWorkspace");
//
//           NSObject* workspace = [lsawsc performSelector:NSSelectorFromString(@"defaultWorkspace")];
//
//           NSArray *appList = [workspace performSelector:@selector(allApplications)];
//
//           Class LSApplicationProxy_class = object_getClass(@"LSApplicationProxy");
//
//           for (LSApplicationProxy_class in appList)
//
//           {
//              //这里可以查看一些信息
//
//               NSString *bundleID = [LSApplicationProxy_class performSelector:@selector(applicationIdentifier)];
//
//               NSString *version =  [LSApplicationProxy_class performSelector:@selector(bundleVersion)];
//
//               NSString *shortVersionString =  [LSApplicationProxy_class performSelector:@selector(shortVersionString)];
//
//               if ([bundleID isEqualToString:bundleID]) {
//                   return  YES;
//               }
//           }
//           return NO;
//
//       }
//    return NO;
//
//}


//这个方法简单高效，也有使用前提，需要提前知晓目标APP的URL Schemes ，这个URL Schemes 查找方式跟上面 bundle ID一样，也在info.plist中，在URL types数组下。
//同时也有缺点，ios9以上的系统，需要设置白名单，否则就是目标APP安装了，方法二也会返回NO。
//白名单设置方式：在info.plist中添加
//<key>LSApplicationQueriesSchemes</key>
//
//    <array>
//
//        <string>您的urlSchemes</string>
//
//    </array>

- (void)funtionCanOpenURL {
   if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"IOSDevApp://"]]){

       //说明此设备有安装app

   }else{

       //说明此设备没有安装app

   };
}

//方式三 导入#include <objc/runtime.h>
//使用上述方式，首先要先知晓目标App的bundle ID。查bundle ID方法的是下载目标App的ipa安装包，将.ipa改成.zip，然后右键显示包内容，查找到info.plist文件，打开找到Bundle identifier对应的value值就是bundle ID了。
//
//缺点：方法一消耗一定的性能（手机安装APP比较多的话），APP审核有可能被拒
//
//优点：跳过了ios9.0对canOpenURL这个API使用限制
//- (void)function3
//{
//   Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
//
//   NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
//
//   NSArray *allApplications = [workspace performSelector:@selector(allApplications)];//这样就能获取到手机中安装的所有App
//
//   NSLog(@"设备上安装的所有app:%@",allApplications);    NSInteger zlConnt = 0;
//
//   for (NSString *appStr in allApplications) {
//
//         NSString *app = [NSString stringWithFormat:@"%@",appStr];//转换成字符串
//
//           NSRange range = [app rangeOfString:@"你要查询App的bundle ID"];//是否包含这个bundle ID
//
//            if (range.length > 1) {
//
//                   zlConnt ++;
//
//            }
//
//      }
//
//      if (zlConnt >= 1) {
//
//           NSLog(@"已安装");
//
//       }
//}

//-(BOOL)checkAPPIsExist:(NSString*)URLScheme{
//    NSURL* url;
//    if ([URLScheme containsString:@"://"]) {
//        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",URLScheme]];
//    } else {
//        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@://",URLScheme]];
//    }
//    if ([[UIApplication sharedApplication] canOpenURL:url]){
//        return YES;
//    } else {
//        return NO;
//    }
//}

//-(void)openWechat{
//    NSURL * url = [NSURL URLWithString:@"weixin://"];
//    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
//    //先判断是否能打开该url
//    if (canOpen)
//    {   //打开微信
//        [[UIApplication sharedApplication] openURL:url];
//    }else {
//        [MBProgressHUD showMoreLine:@"您的设备未安装微信APP" view:nil];
//    }
//}




@end
