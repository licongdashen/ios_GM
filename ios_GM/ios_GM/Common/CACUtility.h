//
//  CACUtility.h
//  cacwallte
//
//  Created by Queen on 2017/4/25.
//  Copyright © 2017年 licong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CACUtility : NSObject

/**
 提示框 1.2秒消失

 @param tips 提示内容
 */
+ (void)showTips:(NSString *)tips;
//检测银行卡号正确性
+ (BOOL)checkBankCardNumber:(NSString *)bankCardNo;
//检测身份证号是否正确(高强度验证)
+ (BOOL)checkIDNum:(NSString *)str;
//出生日期和性别与身份证号匹配的方法
+ (NSString *)checkIDNum:(NSString *)str bith:(NSString *)birth gender:(NSString *)gender;
//性别与身份证号匹配的方法
+ (NSString *)checkIDNum:(NSString *)str gender:(NSString *)gender;
//获取用户头像
+ (UIImage *)getUserHeadPortraitImage:(NSString *)headName;
//获取消息图片
+ (UIImage *)getUserMessageImage:(BOOL)login;
/** 检测头像文件是否存在 */
+ (BOOL)checkUserHeadImageFileExists:(NSString *)headName;
//传入一个时间戳，获取指定格式的时间
+ (NSString *)getNewDateWithFormatter:(NSString *)formatter oldDate:(NSString *)oldDate;
//当前时间，加减年月日
+ (NSString *)getNewDateWithFormatter:(NSString *)formatter AddYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day;
//计算指定字符串的Size
+ (CGSize )getStringSize:(NSString*)l_str_input font:(UIFont*)l_font width:(CGFloat)l_width;
//计算指定字符串的高
+ (CGFloat)getStringHeight:(NSString*)l_str_input font:(UIFont*)l_font width:(CGFloat)l_width;
// 判断对象是否为空
+(BOOL)isNullObject:(id )object;
//判断字符串是否为空
+ (BOOL) isBlankString:(NSString*)string;
//获取颜色（16进制）
+ (UIColor *)getColorFromRGB:(NSString *)inColorString;
//验证注册用户名格式
+ (BOOL) validateUserName:(NSString *)userName;
//验证邮箱格式
+ (BOOL)validateEmail:(NSString *)email;
//验证密码格式
+ (BOOL)validatePassword:(NSString *)passWord;
//验证密码格式（只包含字母）
+ (BOOL)validatePasswordWithOnlyLetter:(NSString *)passWord;
//验证密码格式（只包含数字）
+ (BOOL)validatePasswordWithOnlyNum:(NSString *)passWord;
//验证密码格式(6-20位，不能纯数字或纯字母,可包含符号)
+ (BOOL)validatePasswordWithLetterAndNum:(NSString *)passWord;
//验证真实姓名（汉字或英文名）
+ (BOOL)validateRealName:(NSString *)realName;
//验证手机号码（13，14，15，17，18开头的）
+ (BOOL)validateTelephoneNum:(NSString *)telephone;
//验证身份证号（15或18位）
+ (BOOL)validateIdentityCard: (NSString *)identityCard;
//验证数字（大于0的整数）
+ (BOOL)validateNumber: (NSString *)number;
//排除特殊符号
+ (BOOL)validateSpecialSymbols: (NSString *)symbols;
//验证固定号码
+ (BOOL)validateHomephone:(NSString *)homephone;
//验证数字（非负，可小数）
+ (BOOL)validateWithDecimalNumbers:(NSString *)num;
//验证网址url
+ (BOOL)validateWithURL:(NSString *)urlStr;

/**
 判断当前url地址是否为合法URL
 *
 */
+(BOOL)isUrl:(NSString *)url;
/**
 取出当前url地址中所有参数
 *
 */
+ (NSDictionary *)formatURLParamsWithURLString:(NSString *)urlString;

/**
 追加h5地址参数

 @param sourceURL 原h5地址
 @param paramsDic 追加的参数
 @return 追加参数后的h5地址
 */
+(NSString *)formatHtmlURL:(NSString *)sourceURL withParams:(NSDictionary *)paramsDic;
//Unicode转化为汉字
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;
//utf-8转Unicode
+ (NSString *)utf8ToUnicode:(NSString *)string;
//计算字符串大小
+ (CGSize)autoCalculateRectWithSingleText:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;
//得到UUID
+ (NSString*)getUUID;
//手机型号
+ (NSString *)getPhoneModel;
//加密验证码
+ (NSString *)encryptCode:(NSString*)phoneNo imgCode:(NSString*)imgCode;
//昵称(字母或数字)
+ (BOOL)validateNickName:(NSString *)nickname;
//时间戳转换为  xx天xx小时xx分:xx秒 的格式
+ (NSString *)dateMMssFromString:(NSString *)dateString;

/**
 时间戳是否为当前月
 
 @param timeInterval 后端返回的时间戳,精确到毫秒
 @return 是否为当前月标记
 */
+ (BOOL)formattingTimeIntervalIsCurrentMonth:(NSString *)timeInterval;

/**
 时间戳转换

 @param timeInterval 后端返回的时间戳,精确到毫秒
 @param formatterString 时间戳解析格式
 @return 返回解析成功的字符串
 */
+ (NSString *)getDateYMDFromTimerInterval:(NSString *)timeInterval withDateFormat:(NSString *)formatterString;
/**
 时间戳转换
 
 @param timeInterval 想要转换的时间字符串
 @param formatterString 时间戳解析格式
 @return 返回转换后的时间戳(未精确到毫秒)
 */
+ (long)dateTimestampSince1970WithDateString:(NSString *)dateString withDateFormat:(NSString *)formatterString;
/**
 取出本地bank bin字典

 @return 本地bank bin字典
 */
+ (NSDictionary *)bankCodeDictionary;

/**
 使用千分位日格式化数值字符串

 @param formatString 传入要格式化的字符串
 @return 格式化的千分位
 */
+ (NSString *)formatDieTausendstelFromDecimalString:(NSString *)formatString;
@end
