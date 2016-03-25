//
//  ProvinceCityViewController.m
//  市-简称+车牌两级联动
//
//  Created by 樊志远 on 16/3/24.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "ProvinceCityViewController.h"
#import "DBTool.h"
#import "ProvinceItem.h"
#import "CityViewController.h"


@interface ProvinceCityViewController ()

/** <#注释#> */
@property (nonatomic , strong) NSArray *provinceArr;


@end

@implementation ProvinceCityViewController

- (NSArray *)provinceArr
{
    if (!_provinceArr) {
        DBTool *dbTool = [[DBTool alloc] init];
        NSArray *provinceArr = [dbTool getProvinceList];
        _provinceArr = [NSArray arrayWithArray:provinceArr];
    }
    return _provinceArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.provinceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"province";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    ProvinceItem *pItem = self.provinceArr[indexPath.row];
    
    cell.textLabel.text = pItem.ProvinceName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProvinceItem *pItem = self.provinceArr[indexPath.row];
    
    CityViewController *cityVC = [[CityViewController alloc] init];
    cityVC.ProvinceID = pItem.ProvinceID;
    
    [self.navigationController pushViewController:cityVC animated:YES];
}


@end