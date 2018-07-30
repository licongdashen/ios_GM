//
//  NowAndSoonCollectionCell.m
//  CMmovies
//
//  Created by caimiao on 15/7/6.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import "NowAndSoonCollectionCell.h" 
@interface NowAndSoonCollectionCell()

/**
 *  电影图片
 */
@property (nonatomic, weak)UIImageView *movieImagV;

@property (nonatomic, weak)UILabel *nameLb;

@property (nonatomic, weak)UILabel *amountLb;

@end

@implementation NowAndSoonCollectionCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //背景图片
        UIImageView *movieImagV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_RESIZE_UI(170), DEF_RESIZE_UI(120))];
        movieImagV.backgroundColor = DEF_RGB(62, 62, 62);
        movieImagV.clipsToBounds = YES;
        movieImagV.contentMode = UIViewContentModeScaleAspectFill;
        movieImagV.layer.cornerRadius = 5;
        [self.contentView addSubview:movieImagV];
        self.movieImagV = movieImagV;
        
        //电影名字
        UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(0, DEF_RESIZE_UI(91), DEF_RESIZE_UI(170 - 12), 17)];
        nameLb.font = DEF_MyFont(16);
        nameLb.textColor = [UIColor whiteColor];
        nameLb.textAlignment = NSTextAlignmentRight;
        [movieImagV addSubview:nameLb];
        self.nameLb = nameLb;

        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)setModel:(NSMutableDictionary *)model
{
    _model = model;
    
    if ([DEF_OBJECT_TO_STIRNG(model[@"type"])isEqualToString:@""]) {
        [self.movieImagV sd_setImageWithURL:[NSURL URLWithString:model[@"image"]]placeholderImage:DEF_IMAGE(@"test")];
        self.nameLb.text = model[@"name"];
        self.nameLb.frame = CGRectMake(0, DEF_RESIZE_UI(91), DEF_RESIZE_UI(170 - 12), 17);
        self.nameLb.textAlignment = NSTextAlignmentRight;

    }else{
        self.nameLb.text = @"期待更多";
        self.nameLb.frame = CGRectMake(0, 0, DEF_RESIZE_UI(170), DEF_RESIZE_UI(120));
        self.nameLb.textAlignment = NSTextAlignmentCenter;

    }
   
    

}

@end
