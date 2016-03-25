//
//  DBTool.m
//  市-简称+车牌两级联动
//
//  Created by 樊志远 on 16/3/24.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "DBTool.h"
#import <FMDB.h>
#import "ProvinceItem.h"

/** 数据库队列 */
static FMDatabaseQueue *_queue;

@implementation DBTool

+ (void)initialize
{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Province.sqlite"];
    
    _queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL result = NO;
        result = [db executeUpdate:@"CREATE TABLE if not exists Province(ProvinceID text Primary Key ,Name text , Abbreviation text)"];
        if (result) {
            result = [db executeUpdate:@" CREATE TABLE if not exists City(CityID text Primary Key ,ProvinceID text ,Name text)"];
            if(!result)
            {
                NSLog(@"创建表:City 失败");
            }
        }
        else
        {
            NSLog(@"创建表:Province 失败");
        }
        
        
        
    }];
}

- (NSArray *)getProvinceList
{
    __block  NSMutableArray *provinceArr = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
       
        FMResultSet *set = [db executeQuery:@"select * from Province"];
        while (set.next) {
            ProvinceItem *pItem = [[ProvinceItem alloc] init];
            pItem.ProvinceName = [set stringForColumn:@"Name"];
            pItem.ProvinceID = [set stringForColumn:@"ProvinceID"];
            [provinceArr addObject:pItem];
        }
    }];
    
    return provinceArr;
}

- (NSDictionary *)getProvinceDetailWithProvinceID:(NSString *)ProvinceID
{
    __block NSMutableDictionary *provinceDic = [NSMutableDictionary dictionary];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:@"select * from Province where ProvinceID = ?",ProvinceID];
        while (set.next) {
            provinceDic[@"provinceName"] = [set stringForColumn:@"Name"];
            provinceDic[@"Abbreviation"] = [set stringForColumn:@"Abbreviation"];
        }
    }];
    return provinceDic;

}

- (NSArray *)getCityListWithProvinceID:(NSString *)ProvinceID
{
    __block NSMutableArray *cityArr = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:@"select * from City where ProvinceID = ?",ProvinceID];
        while (set.next) {
            [cityArr addObject:[set stringForColumn:@"Name"]];
        }
    }];
    return cityArr;
}

//- (NSString *)getAbbreviationWihtProvinceID:(NSString *)ProvinceID
//{
//    __block NSString *abbreviation = nil;
//    [_queue inDatabase:^(FMDatabase *db) {
//        FMResultSet *set = [db executeQuery:@"select Abbreviation from Province where ProvinceID = ?",ProvinceID];
//        while (set.next) {
//            abbreviation = [set stringForColumn:@"Abbreviation"];
//        }
//    }];
//    return abbreviation;
//}





@end
