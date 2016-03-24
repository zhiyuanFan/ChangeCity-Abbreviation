//
//  DBTool.h
//  市-简称+车牌两级联动
//
//  Created by 樊志远 on 16/3/24.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBTool : NSObject

/**
 *  获得所有省份数据
 *
 *  @return 省份模型数组
 */
- (NSArray *)getProvinceData;


/**
 *  根据省份ID获取城市数据
 */
- (NSArray *)getCityDataWithProvinceID:(NSString *)ProvinceID;


/**
 *  根据省份ID获取省份简称
 *
 */
- (NSString *)getAbbreviationWihtProvinceID:(NSString *)ProvinceID;

@end
