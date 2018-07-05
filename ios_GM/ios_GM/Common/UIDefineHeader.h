//
//  UIDefineHeader.h
//  cacwallet
//
//  Created by Queen on 2017/4/19.
//  Copyright © 2017年 licong. All rights reserved.
//

#ifndef UIDefineHeader_h
#define UIDefineHeader_h

// 随机色
#define DEF_RANDOM_COLOR [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1]

// 获取RGB颜色
#define DEF_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define DEF_RGB(r,g,b)                  DEF_RGBA(r,g,b,1.0f)

#define DEF_UICOLORFROMRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) DEF_UICOLORFROMRGB(rgbValue)

#define DEF_APP_MAIN_COLOR                         DEF_UICOLORFROMRGB(0xf5f5f5)

//图片背景颜色
#define DEF_IMAGE_BACKGROUND_COLOR              DEF_COLOR_RGB(243, 243, 243)

#define DEF_APP_MAIN_TITLECOLOR                  DEF_UICOLORFROMRGB(0x4b4948)

//黑色透明度
#define BLACKALPHA    0.2

#define DEF_BLACKALPHA BLACKALPHA

//登录注册界面常用值
#define FORGETPASSWORD_BUTTON_TITLE_COLOR        DEF_UICOLORFROMRGB(0x707070)

#define LOGIN_BACKGOUND_COLOR           DEF_UICOLORFROMRGB(0xffffff)

#define RIGISTER_BACKGOUND_COLOR        DEF_UICOLORFROMRGB(0xeff2f7)

#define TEXTFIELD_BORDER_COLOR          DEF_UICOLORFROMRGB(0xa9a9a9)

#define TEXTFIELD_PLACEHODER_COLOR      DEF_UICOLORFROMRGB(0xCCCCCC)

#define TEXTFIELD_SEPARATOR_COLOR       DEF_UICOLORFROMRGB(0xE3E4E4)

#define TEXTFIELD_TEXT_COLOR            DEF_UICOLORFROMRGB(0x000000)

#define BUTTON_COLOR                    DEF_UICOLORFROMRGB(0xe65659)

#define BUTTON_TITLE_COLOR              DEF_UICOLORFROMRGB(0xFFFFFF)

#define BUTTON_NORMAL_COLOR              DEF_UICOLORFROMRGB(0xFE4032)

#define BUTTON_HEIGHTLIGHT_COLOR         DEF_UICOLORFROMRGB(0xE5392D)

#define QUICK_REGISTER_BUTTON_NORMAL_COLOR            DEF_UICOLORFROMRGB(0x3e3e3e)

#define QUICK_REGISTER_BUTTON_HEIGHTLIGHT_COLOR       DEF_UICOLORFROMRGB(0x333333)

#define QUICK_REGISTER_BUTTON_TEXT_COLOR              DEF_UICOLORFROMRGB(0xe1e1e1)

#define LINE_BACKCOLOR    DEF_UICOLORFROMRGB(0xeff2f7)

#define BUTTON_GRAY_COLOR               DEF_UICOLORFROMRGB(0xcccccc)

#define BUTTON_BLACK_COLOR              DEF_UICOLORFROMRGB(0x323743)

//btn倒计时时间
#define BTN_COUNTDOWN_TIME              60

//红色大按钮高度
#define RED_BUTTON_HEIGHT               50

//textfield
#define LOGOVIEW_HEIGHT                 150

#define TEXTFIELD_HEIGHT                40

#define LEFT_MARGIN                     20

#define CORNER_RADIUS                   25.0

#define INPUT_LEFT_MARGIN               12

#define CHECK_CODE_HEIGHT               27

//带输入框的白色View高度
#define SETTING_WHITEVIEW_HEIGHT        70

#define WINDOW_COLOR_AND_ALPHA    [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]

#endif /* UIDefineHeader_h */
