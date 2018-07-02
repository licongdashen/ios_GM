//
//  CACUtility.m
//  cacwallte
//
//  Created by Queen on 2017/4/25.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "CACUtility.h"
#import "NSString+MD5.h"

@implementation CACUtility

+ (void)showTips:(NSString *)tips
{
    if ([CACUtility isBlankString:tips])return;
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text = tips;
        hud.margin = 20.0;
        hud.label.numberOfLines = 3;
        hud.removeFromSuperViewOnHide = YES;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:3];
    });
}

//检测银行卡号正确性
+ (BOOL)checkBankCardNumber:(NSString *)bankCardNo
{
    int length = (int)bankCardNo.length;
    
    if (length < 12) {
        return NO;
    }
    
    int oddsum = 0;
    int evensum = 0;
    int allsum = 0;
    
    for (int i = length - 1; i >= 0; i--)
    {
        NSString *tmpString = [bankCardNo substringWithRange:NSMakeRange(i, 1)];
        int tmpVal = [tmpString intValue];
        if(((length - i) % 2) == 0){    //倒数偶数位
            tmpVal *= 2;
            if(tmpVal>=10)
                tmpVal -= 9;
            evensum += tmpVal;
        }else{
            oddsum += tmpVal;
            
        }
    }
    allsum = oddsum + evensum;
    
    if((allsum % 10) == 0) {
        return YES;
    }
    else {
        return NO;
    }
}

//检测身份证号是否正确(高强度验证)
+ (BOOL)checkIDNum:(NSString *)str{
    
    BOOL isMatch = NO;
    
    if (str==nil) {
        return isMatch;
    }
    
    if(str.length!=15&&str.length!=18)
    {
        return isMatch;
        
    }
    
    NSDictionary *dic = [CACUtility cardNumAreaDic];
    if (![dic valueForKey:[str substringToIndex:2]]) {
        return isMatch;
    }
    
    NSArray *strJiaoYan = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5",
                           @"4", @"3", @"2", nil];
    
    NSArray *arr = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    
    if (str.length == 15) {
        NSString *ereg = @"";
        
        if (([[str substringWithRange:NSMakeRange(6, 2)]intValue]+1900)%4 == 0
            || (([[str substringWithRange:NSMakeRange(6, 2)]intValue]+1900)%100 == 0
                && ([[str substringWithRange:NSMakeRange(6, 2)]intValue]+1900)%4 == 0)) {
                ereg = @"[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}";// 测试出生日期的合法性
            }else{
                ereg = @"[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}";// 测试出生日期的合法性
            }
        
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ereg];
        isMatch = [pred evaluateWithObject:str];
        if (isMatch == NO) {
            return isMatch;
            
        }
        //        isMatch = NO;
        str = [NSString stringWithFormat:@"%@19%@",[str substringToIndex:6],[str substringWithRange:NSMakeRange(6, 9)]];
        
        int intTemp = 0;
        
        for (int i = 0; i<17; i++) {
            intTemp = intTemp + ([[str substringWithRange:NSMakeRange(i, 1)]intValue] * [[arr objectAtIndex:i]intValue]);
        }
        
        intTemp = intTemp % 11;
        str = [NSString stringWithFormat:@"%@%@",str,[strJiaoYan objectAtIndex:intTemp]];
    }
    if (str.length == 18) {
        NSString *ereg1 = @"";
        if (([[str substringWithRange:NSMakeRange(6, 4)]intValue])%4 == 0
            || (([[str substringWithRange:NSMakeRange(6, 4)]intValue])%100 == 0
                && ([[str substringWithRange:NSMakeRange(6, 4)]intValue])%4 == 0)) {
                ereg1 = @"[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]";// 闰年出生日期的合法性正则表达式
            } else {
                ereg1 = @"[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]";// 平年出生日期的合法性正则表达式
            }
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ereg1];
        isMatch = [pred evaluateWithObject:str];//610423198210293718
        if (isMatch == NO) {
            return isMatch;
            
        }
        isMatch = NO;
        
        int intTemp = 0;
        
        for (int i = 0; i<17; i++) {
            intTemp = intTemp + ([[str substringWithRange:NSMakeRange(i, 1)]intValue] * [[arr objectAtIndex:i]intValue]);
        }
        
        intTemp = intTemp % 11;
        
        NSString *last = [strJiaoYan objectAtIndex:intTemp];// 判断校验位
        
        if (![last compare:[str substringWithRange:NSMakeRange(17, 1)] options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            return isMatch;
        }
        
    }
    isMatch = YES;
    return isMatch;
}

+ (NSDictionary *)cardNumAreaDic{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"海外" forKey:@"91"];
    return dic;
    
}
//出生日期和性别与身份证号匹配的方法
+ (NSString *)checkIDNum:(NSString *)str bith:(NSString *)birth gender:(NSString *)gender{
    NSString *result = nil;
    if ([CACUtility checkIDNum:str] == YES) {
        NSString *bir = @"";
        NSString *gen = @"";
        if (str.length == 18) {
            bir = [str substringWithRange:NSMakeRange(6, 8)];
            gen = [str substringWithRange:NSMakeRange(16, 1)];
        }else{
            bir = [str substringWithRange:NSMakeRange(6, 6)];
            bir = [NSString stringWithFormat:@"19%@",bir];
            gen = [str substringWithRange:NSMakeRange(14, 1)];
        }
        
        birth = [NSString stringWithFormat:@"%@%@%@",[birth substringToIndex:4],[birth substringWithRange:NSMakeRange(5, 2)],[birth substringFromIndex:8]];
        
        if (![birth isEqualToString:bir]) {
            result = @"身份证号和出生日期不匹配";
        }
        if ([gen intValue]%2 == 0) {
            gen = @"女";
        }else{
            gen = @"男";
        }
        if (![gender isEqualToString:gen]) {
            result = @"身份证号和性别不匹配";
        }
        
    }else{
        result = @"请输入正确的身份证号";
    }
    
    return result;
}

//性别与身份证号匹配的方法
+ (NSString *)checkIDNum:(NSString *)str gender:(NSString *)gender{
    NSString *result = nil;
    if ([CACUtility checkIDNum:str] == YES)
    {
        NSString *gen = @"";
        if (str.length == 18) {
            gen = [str substringWithRange:NSMakeRange(16, 1)];
        }else{
            gen = [str substringWithRange:NSMakeRange(14, 1)];
        }
        
        if ([gen intValue]%2 == 0) {
            gen = @"女";
        }else{
            gen = @"男";
        }
        if (![gender isEqualToString:gen]) {
            result = @"身份证号和性别不匹配!";
        }
        
    }else{
        result = @"请输入正确的身份证号!";
    }
    
    return result;
}

//获取用户头像
+ (UIImage *)getUserHeadPortraitImage:(NSString *)headName
{
    UIImage *image= nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageDirectory = [documentsDirectory stringByAppendingPathComponent:@"AvatorCaches"];
    if (![fileManager fileExistsAtPath:imageDirectory]) {
        [fileManager createDirectoryAtPath:imageDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *imagePath = [imageDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",headName]];
    
    if ([fileManager fileExistsAtPath:imagePath]) {//判断文件是否存在
        image = [UIImage imageWithContentsOfFile:imagePath];
    }else {
        image = [UIImage imageNamed:@"ic_default"];
    }
    
    return image;
}

//获取消息图片
+ (UIImage *)getUserMessageImage:(BOOL)login
{
    if (login) {
        return [UIImage imageNamed:@"no_message"];
    } else {
        return nil;
    }
}

/** 检测头像文件是否存在 */
+ (BOOL)checkUserHeadImageFileExists:(NSString *)headName
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageDirectory = [documentsDirectory stringByAppendingPathComponent:@"AvatorCaches"];
    if (![fileManager fileExistsAtPath:imageDirectory]) {
        [fileManager createDirectoryAtPath:imageDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *imagePath = [imageDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",headName]];
    
    if ([fileManager fileExistsAtPath:imagePath]) {//判断文件是否存在
        return YES;
    }
    
    return NO;
}

//传入一个时间戳，获取指定格式的时间
+ (NSString *)getNewDateWithFormatter:(NSString *)formatter oldDate:(NSString *)oldDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    if (formatter == nil || oldDate == nil) {
        return @"";
    }
    [df setDateFormat:formatter];
    double timeInterval = [oldDate doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSString *newTime = [df stringFromDate:date];
    
    return newTime;
}

+ (NSString *)getNewDateWithFormatter:(NSString *)formatter AddYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    
    NSDate *date = [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
    
    //得到本地时间，避免时区问题
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate:date];
    //    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:formatter];
    
    NSString *dateStr = [df stringFromDate:date];
    
    return dateStr;
}

//计算指定字符串的Size
+ (CGSize )getStringSize:(NSString*)l_str_input font:(UIFont*)l_font width:(CGFloat)l_width
{
    if (l_str_input == nil || l_font == nil || l_width <= 0) {
        return CGSizeZero;
    }
    
    CGSize l_size = CGSizeMake(l_width, MAXFLOAT);
    
    //    if (IOS_Version >= 7.0)
    //    {
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:l_font, NSFontAttributeName,
                                          nil];
    
    CGSize textSize = [l_str_input boundingRectWithSize:l_size//用于计算文本绘制时占据的矩形块
                                                options:NSStringDrawingUsesLineFragmentOrigin//文本绘制时的附加选项
                                             attributes:attributesDictionary// 文字的属性
                                                context:nil].size;
    return textSize;
    
    //    }
    //    else{
    //
    //        CGSize textSize = [l_str_input sizeWithFont:l_font
    //                                  constrainedToSize:l_size
    //                                      lineBreakMode:NSLineBreakByWordWrapping];
    //
    //        return textSize;
    //
    //    }
    
}


//计算指定字符串的高
+ (CGFloat)getStringHeight:(NSString*)l_str_input font:(UIFont*)l_font width:(CGFloat)l_width
{
    if (l_str_input == nil || l_font == nil || l_width <= 0) {
        return 0.0f;
    }
    
    CGSize l_size = CGSizeMake(l_width, MAXFLOAT);
    
    //    if (IOS_Version >= 7.0)
    //    {
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:l_font, NSFontAttributeName,
                                          nil];
    
    CGSize textSize = [l_str_input boundingRectWithSize:l_size//用于计算文本绘制时占据的矩形块
                                                options:NSStringDrawingUsesLineFragmentOrigin//文本绘制时的附加选项
                                             attributes:attributesDictionary// 文字的属性
                                                context:nil].size;
    return textSize.height;
    
    //    }
    //    else{
    //        CGSize textSize = [l_str_input sizeWithFont:l_font
    //                                  constrainedToSize:l_size
    //                                      lineBreakMode:NSLineBreakByWordWrapping];
    //
    //        return textSize.height;
    //
    //    }
    
}

//判断对象是否为空
+(BOOL)isNullObject:(id )object {
    if([object isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if([object isEqual:[NSNull null]]) {
        return YES;
    }
    if (object == nil) {
        return YES;
    }
    return NO;
}

//判断string是否为空
+(BOOL)isBlankString:(NSString*)string
{
    if([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if([string isEqual:[NSNull null]]) {
        return YES;
    }
    if (string == nil) {
        return YES;
    }
    if([string isEqualToString:@""]) {
        return YES;
    }
    if ([string isEqualToString:@"null"])
    {
        return YES;
    }
    //    if([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
    //        return YES;
    //    }
    return NO;
}

//通过RGB获得颜色
+ (UIColor *)getColorFromRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

//账号(字母或数字)
+ (BOOL)validateUserName:(NSString *)userName
{
    NSString *userNameRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:userName];
}

//昵称(字母或数字)
+ (BOOL)validateNickName:(NSString *)nickname
{
    NSString *userNameRegex = @"^[\u4e00-\u9fa5a-zA-Z0-9]{0,160}";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:nickname];
}

//邮箱
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//密码(字母、数字或符号组合)
+ (BOOL)validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    //    NSString *passWordRegex = @"^[\x21-\x7e]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

//密码（只包含字母）
+ (BOOL)validatePasswordWithOnlyLetter:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

//密码（只包含数字）
+ (BOOL)validatePasswordWithOnlyNum:(NSString *)passWord
{
    NSString *passWordRegex = @"^[0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

/** 验证密码格式(6-16位，不能纯数字或纯字母,可包含符号) */
+ (BOOL)validatePasswordWithLetterAndNum:(NSString *)passWord
{
    
    //    NSString *passWordRegex = @"(?![^a-zA-Z]+$)(?!\\D+$).{6,16}";   //不支持符号加数字
    //    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    //    return [passWordPredicate evaluateWithObject:passWord];
    
//    if (passWord.length < 6 || passWord.length > 16) {
//        return NO;
//    }
//
//    NSString *letterRegex = @"^[a-zA-Z]{6,16}+$";
//    NSPredicate *letterPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",letterRegex];
//    NSLog(@"%d",[letterPredicate evaluateWithObject:passWord]);
//    if ([letterPredicate evaluateWithObject:passWord]) {
//        return NO;
//    }
//
//    NSString *numberRegex = @"^[0-9]{6,16}+$";
//    NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
//    NSLog(@"%d",[numberPredicate evaluateWithObject:passWord]);
//    if ([numberPredicate evaluateWithObject:passWord]) {
//        return NO;
//    }
//
//    NSString *symbolsRegex = @"^[^a-zA-Z0-9]{6,16}+$";
//    NSPredicate *symbolsPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",symbolsRegex];
//    NSLog(@"%d",[symbolsPredicate evaluateWithObject:passWord]);
//    if ([symbolsPredicate evaluateWithObject:passWord]) {
//        return NO;
//    }
    
    NSString * symbolsRegex = @"^(?![\\d]+$)(?![a-zA-Z]+$)(?![^\\da-zA-Z]+$).{6,16}$";
    NSPredicate * symbolsPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",symbolsRegex];
    NSLog(@"%d",[symbolsPredicate evaluateWithObject:passWord]);
    
    return [symbolsPredicate evaluateWithObject:passWord];
    
}

//真实姓名
+ (BOOL)validateRealName:(NSString *)realName
{
    NSString *realNameRegex = @"^[\u4E00-\u9FA5a-zA-Z\\d.]+$";
    NSPredicate *realNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",realNameRegex];
    return [realNamePredicate evaluateWithObject:realName];
}

//手机号码
+ (BOOL)validateTelephoneNum:(NSString *)telephone
{
    //    NSString *telephoneRegex = @"^(0|86|17951)?(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])[0-9]{8}$";
    NSString *telephoneRegex = @"^(0|86|17951)?(1[0-9])[0-9]{9}$";
    NSPredicate *telephonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",telephoneRegex];
    return [telephonePredicate evaluateWithObject:telephone];
}

//固定号码
+ (BOOL)validateHomephone:(NSString *)homephone
{
    //    NSString *homephoneRegex = @"^(0[0-9]{2,3}+[-]?)?([2-9][0-9]{6,7})+([-]?[0-9]{1,4})?$";
    NSString *homephoneRegex = @"^(0[0-9]{2,3}[-])?([2-9][0-9]{6,7})+([-][0-9]{1,4})?$";
    NSPredicate *homephonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",homephoneRegex];
    return [homephonePredicate evaluateWithObject:homephone];
}

//身份证号
+ (BOOL)validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//数字（整数）
+ (BOOL)validateNumber: (NSString *)number
{
    BOOL flag;
    if (number.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^[1-9][0-9]*$";
    NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [numberPredicate evaluateWithObject:number];
}

//排除特殊符号
+ (BOOL)validateSpecialSymbols: (NSString *)symbols
{
    BOOL flag;
    if (symbols.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^[A-Za-z0-9\u4E00-\u9FA5_-]{1,10}+$";
    NSPredicate *symbolsPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [symbolsPredicate evaluateWithObject:symbols];
}

//判断数字是否正确
+ (BOOL)validateWithDecimalNumbers:(NSString *)num
{
    BOOL flag;
    if (num.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(([0-9][.][0-9]*[1-9][0-9]*)|([1-9][0-9]*[.][0-9]+)|([1-9][0-9]*)|0|0.0|0.00)$";
    NSPredicate *numPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [numPredicate evaluateWithObject:num];
}

//验证网址url
+ (BOOL)validateWithURL:(NSString *)urlStr
{
    NSString *urlStrRegex = @"^[a-zA-z]+://[^\\s]*$";
    NSPredicate *urlStrPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",urlStrRegex];
    return [urlStrPredicate evaluateWithObject:urlStr];
}

// 判断当前url是否为合法URL地址
+(BOOL)isUrl:(NSString *)url {
    if(!url){
        return NO;
    }
    NSString * URLpattern = @"^(http|https)://";
    
    NSError *error = NULL;
    NSRegularExpression *URLregex = [NSRegularExpression regularExpressionWithPattern:URLpattern
                                                                              options:NSRegularExpressionCaseInsensitive
                                                                                error: &error];
    
    NSUInteger numberOfMatches = [URLregex numberOfMatchesInString:url
                                                           options:0
                                                             range:NSMakeRange(0, [url length])];
    if (numberOfMatches == 0) {
        return NO;
    }
    
    NSURL *URL = [NSURL URLWithString:url];
    if(!URL){
        return NO;
    }
    
    return YES;
}

// 取出当前URL地址中的所有参数
+ (NSDictionary *)formatURLParamsWithURLString:(NSString *)urlString {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithCapacity:0];
    if ([CACUtility isUrl:urlString]) {
        NSURLComponents *URLComponents = [NSURLComponents componentsWithString:urlString];
        NSArray *URLqueryItems = URLComponents.queryItems;
        if (URLComponents && URLqueryItems.count >0) {
            for (NSURLQueryItem *item in URLqueryItems) {
                [mutableDict setObject:item.value forKey:item.name];
            }
        }
    }
    return [mutableDict copy];
}

+(NSString *)formatHtmlURL:(NSString *)sourceURL withParams:(NSDictionary *)paramsDict {
    //guard
    if(![CACUtility isUrl:sourceURL]){
        return sourceURL;
    }
    if(!paramsDict){
        paramsDict = [NSDictionary dictionary];
    }
    
    //格式化地址中重复的//
    NSURL *URL = [NSURL URLWithString:sourceURL];
    NSString *relativePath = [URL.relativePath stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
    sourceURL = [sourceURL stringByReplacingOccurrencesOfString:URL.relativePath withString:relativePath];
    //1,获取URL中的所有参数
    NSDictionary *originParamsDict = [CACUtility formatURLParamsWithURLString:sourceURL];
    NSMutableDictionary *mutableParamsDict = [NSMutableDictionary dictionaryWithDictionary:originParamsDict];
    
    //2,追加传入的参数
    [mutableParamsDict addEntriesFromDictionary:paramsDict];
    
    NSString *URLString = [[sourceURL componentsSeparatedByString:@"?"] firstObject];
    NSURLComponents *urlComponts = [NSURLComponents componentsWithString:URLString];
    
    __block NSMutableArray *URLqueryItems = [NSMutableArray arrayWithCapacity:0];
    //遍历参数字典追加或者更新或者更新参数
    [mutableParamsDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSURLQueryItem *itemSid = [NSURLQueryItem queryItemWithName:key value:obj];
        [URLqueryItems addObject:itemSid];
    }];
    [urlComponts setQueryItems:URLqueryItems];
    return urlComponts.URL.absoluteString;
}

//Unicode转化为汉字
+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    
}

//utf-8转Unicode
+ (NSString *)utf8ToUnicode:(NSString *)string {
    
    NSUInteger length = [string length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++) {
        unichar _char = [string characterAtIndex:i];
        //判断是否为英文和数字
        if (_char <= '9' && _char >= '0') {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
            
        } else if(_char >= 'a' && _char <= 'z') {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
            
        } else if(_char >= 'A' && _char <= 'Z') {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
            
        } else {
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
        }
        
    }
    
    return s;
}

//计算字符串大小
+ (CGSize)autoCalculateRectWithSingleText:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    
    NSDictionary* attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize stringSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    stringSize.height=ceil(stringSize.height);
    
    stringSize.width=ceil(stringSize.width);
    
    return stringSize;
}

+ (NSString*)getUUID
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result ;
}

/** 获取手机型号 */
+ (NSString *)getPhoneModel
{
    NSString *phoneModel = [[UIDevice currentDevice] model];
    return phoneModel;
}

+ (NSString *)encryptCode:(NSString*)phoneNo imgCode:(NSString*)imgCode
{
    if (phoneNo.length <= 0 || imgCode.length <= 0) {
        return @"";
    }
    // 1.imgCode转换为大写字符
    NSString *upperImgCode = [imgCode uppercaseString];
    // 2.获取当前日期
    NSString *dateString = [self getNewDateWithFormatter:@"yyyyMMdd" AddYear:0 Month:0 Day:0];
    // 3.拼接手机号、日期、图形验证码
    NSString *originalStr = [NSString stringWithFormat:@"%@%@%@", phoneNo, dateString, upperImgCode];
    // 4.MD5加密
    NSString *destStr = [originalStr MD5];
    
    return destStr;
}

/**
 *  时间戳转换为  xx天xx小时xx分:xx秒 的格式
 *
 *  @param dateString   时间戳
 *
 *  @return NSString    格式化好的日期
 */
+ (NSString *)dateMMssFromString:(NSString *)dateString;
{
    NSTimeInterval aTimer = fabs(dateString.doubleValue);
    int day     = (int)(aTimer/86400);
    int hour    = (int)(aTimer - day*86400)/3600;
    int minute  = (int)(aTimer -day*86400 -hour*3600)/60;
    int second  = aTimer - day*86400 - hour * 3600 - minute * 60;
    
    NSString *dayStr = day < 10 ? [NSString stringWithFormat:@"0%d",day] : [NSString stringWithFormat:@"%d",day];
    NSString *hourStr = hour < 10 ? [NSString stringWithFormat:@"0%d",hour] : [NSString stringWithFormat:@"%d",hour];
    NSString *minStr  = minute < 10 ? [NSString stringWithFormat:@"0%d",minute] : [NSString stringWithFormat:@"%d",minute];
    NSString *secondStr = second < 10 ? [NSString stringWithFormat:@"0%d",second] : [NSString stringWithFormat:@"%d",second];
    return [NSString stringWithFormat:@"%@:%@:%@:%@",dayStr,hourStr,minStr,secondStr];
}

+ (BOOL)formattingTimeIntervalIsCurrentMonth:(NSString *)timeInterval {
    //服务器时间戳与APP时间戳不一致
    NSDate *rightDate = [NSDate dateWithTimeIntervalSince1970:[timeInterval longLongValue]/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *dateStr = [dateFormatter stringFromDate:rightDate];
    // 获取当前月
    NSDate *date = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSMonthCalendarUnit;
    NSDateComponents *d = [cal components:unitFlags fromDate:date];
    NSInteger month = [d month];
    if (month == [dateStr integerValue]) {
        return YES;
    }
    return NO;
}

//yyyy-MM-dd HH:mm:ss
+ (NSString *)getDateYMDFromTimerInterval:(NSString *)timeInterval withDateFormat:(NSString *)formatterString {
    //服务器时间戳与APP时间戳不一致
    NSDate *rightDate = [NSDate dateWithTimeIntervalSince1970:[timeInterval longLongValue]/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatterString];
    NSString *dateStr = [dateFormatter stringFromDate:rightDate];
    return dateStr;
}

+ (long)dateTimestampSince1970WithDateString:(NSString *)dateString withDateFormat:(NSString *)formatterString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: formatterString];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    //转换时间戳
    return (long)[destDate timeIntervalSince1970];
}

+ (NSDictionary *)bankCodeDictionary {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bankCode.json" ofType:nil];
    if (!path) {
        return @{};
    }
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSDictionary *bankCodeDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    return bankCodeDictionary;
}

+ (NSString *)formatDieTausendstelFromDecimalString:(NSString *)formatString {
    if (!formatString) {
        return @"";
    }
    NSNumberFormatter *formater = [[NSNumberFormatter alloc] init];
    formater.formatterBehavior = NSNumberFormatterBehavior10_4;
    formater.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *string = [formater stringFromNumber:[NSDecimalNumber decimalNumberWithString:formatString]];
    if (![string containsString:@"."]) {
        // 不含小数点,手动追加.00
        string = [string stringByAppendingString:@".00"];
    }
    // 含小数点,判断是否为小数点后一位
    NSRange dotRange = [string rangeOfString:@"."];
    NSString *dotString = [string substringFromIndex:dotRange.location+1];
    if (1 == dotString.length) {
        string = [string stringByAppendingString:@"0"];
    }
    if ([string isEqualToString:@"0"]) {
        // 等于0时,修改为0.00
        return @"0.00";
    }
    return string;
}
@end
