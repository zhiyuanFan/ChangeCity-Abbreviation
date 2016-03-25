//
//  ViewController.m
//  市-简称+车牌两级联动
//
//  Created by 樊志远 on 16/3/24.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "ViewController.h"

#import "ProvinceCityViewController.h"

#import "DBTool.h"

static CGFloat const rgbColor = 239 / 255.0;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *cityView;
@property (weak, nonatomic) IBOutlet UIView *numView;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UILabel *abbreviationLabel;
@property (weak, nonatomic) IBOutlet UITextField *cityField;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCity:) name:@"chooseCity" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cityView.layer.cornerRadius = 10;
    self.numView.layer.cornerRadius = 10;
    self.view.backgroundColor = [UIColor colorWithRed:rgbColor green:rgbColor blue:rgbColor alpha:1.0];

}
- (IBAction)chooseCity:(id)sender {
    
    ProvinceCityViewController *pcVC = [[ProvinceCityViewController alloc] init];
    
    [self.navigationController pushViewController:pcVC animated:YES];
}

- (void)changeCity:(NSNotificationCenter *)note
{
    //根据通知传回来的数据,修改界面
    NSDictionary *dic = [note valueForKey:@"userInfo"];
    
    [self.cityBtn setTitle:dic[@"provinceName"] forState:UIControlStateNormal];
    [self.cityBtn setTitle:dic[@"provinceName"] forState:UIControlStateHighlighted];
    self.abbreviationLabel.text = dic[@"Abbreviation"];
    self.cityField.text = dic[@"cityName"];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
