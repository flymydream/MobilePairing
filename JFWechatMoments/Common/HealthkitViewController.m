//
//  HealthkitViewController.m
//  JFWechatMoments
//
//  Created by hero on 2022/3/10.
//  Copyright © 2022 fanzhiying. All rights reserved.
//

#import "HealthkitViewController.h"
#import<HealthKit/HealthKit.h>

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



@end
