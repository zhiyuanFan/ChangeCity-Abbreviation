//
//  CityViewController.m
//  市-简称+车牌两级联动
//
//  Created by 樊志远 on 16/3/24.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "CityViewController.h"
#import "DBTool.h"

@interface CityViewController ()

/** 城市名数组 */
@property (nonatomic , strong) NSArray *cityArr;

@end

@implementation CityViewController

#pragma mark - lazy load
- (NSArray *)cityArr
{
    if (!_cityArr) {
        DBTool *dbTool = [[DBTool alloc] init];
        _cityArr = [dbTool getCityListWithProvinceID:self.ProvinceID];
    }
    return _cityArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cityArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"City";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = self.cityArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *provinceDic = [[[DBTool alloc] init] getProvinceDetailWithProvinceID:self.ProvinceID];
    
    NSString *cityName = self.cityArr[indexPath.row];
    
    NSMutableDictionary *noteDic = [NSMutableDictionary dictionaryWithDictionary:provinceDic];
    [noteDic setValue:cityName forKey:@"cityName"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseCity" object:nil userInfo:noteDic];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end