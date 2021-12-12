//
//  HDDCustomTextView.m
//  Driver
//
//  Created by caesar on 2020/6/28.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDCustomTextView.h"

@implementation HDDCustomTextView
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    return self;
}
- (void)initialize
{
    [self layoutGUI];
    if (self.lengthMax == 0) {
        self.lengthMax = MAXFLOAT;
    }
    self.tintColor = APPColor;
     _placeholderColor = [UIColor lightGrayColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
}
// 时刻监听文字键盘文字的变化，文字一旦改变便调用setNeedsDisplay方法
- (void)textDidChange
{
    // 该方法会调用drawRect:方法，立即重新绘制占位文字
    [self setNeedsDisplay];
    [self.superview layoutIfNeeded];
    
}
/// UITextView字数限制
/// @param textView textView
/// @param maxCount 限制字数
- (void)textViewMaxTextCount:(UITextView *)textView AndMaxCount:(NSInteger)maxCount{
    NSString *toBeString =textView.text;
    NSString *lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) { // 中文输入
        UITextRange *selectedRange = [textView markedTextRange];
        // 获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > self.lengthMax) {
                textView.text = [toBeString substringToIndex:self.lengthMax];
            }
        }else{//有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > maxCount) {
            textView.text = [toBeString substringToIndex:self.lengthMax];
        }
    }
    if (self.showNumber) {
        _numberLabel.text = NSStringFormat(@"%lu/%ld",(unsigned long)textView.text.length,(long)self.lengthMax);
    }
}

- (void)textChanged:(NSNotification *)notification
{// 该方法会调用drawRect:方法，立即重新绘制占位文字
    
    if (notification.object == self)
        [self layoutGUI];
    //限制输入字数
    [self textViewMaxTextCount:self AndMaxCount:self.lengthMax];
}
- (void)layoutGUI
{
    _placeholderLabel.alpha = [self.text length] > 0 || [_placeholderText length] == 0 ? 0 : 1;
}



#pragma mark - Setters
- (void)setText:(NSString *)text{
    [super setText:text];
    [self layoutGUI];
}
- (void)setPlaceholderText:(NSString*)placeholderText
{
    _placeholderText = placeholderText;
    [self setNeedsDisplay];
}

#pragma mark - drawRect
- (void)drawRect:(CGRect)rect
{
    if ([_placeholderText length] > 0)
    {
        if (!_placeholderLabel)
        {
            _placeholderLabel = [[UILabel alloc] init];
            _placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeholderLabel.numberOfLines = 0;
            _placeholderLabel.font = self.font;
            _placeholderLabel.backgroundColor = [UIColor clearColor];
            _placeholderLabel.alpha = 0;
            [self addSubview:_placeholderLabel];
            
            [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.equalTo(self.mas_left).offset(3);
               make.right.equalTo(self.mas_right).offset(5);
               make.top.equalTo(self.mas_top).offset(7);
            }];
        }
        
        if (self.placeholderLocation == PlaceholderLocationTop) {
            [_placeholderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).offset(7);
            }];
        }else{
            [_placeholderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY);
            }];
        }
        _placeholderLabel.text = _placeholderText;
         _placeholderLabel.textColor = _placeholderColor;
//        [_placeholderLabel sizeToFit];
        
        [self sendSubviewToBack:_placeholderLabel];
    }
    
    if (_showNumber) {
        if (!_numberLabel) {
            _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width - 65, self.height - 22, 60, 22)];
            _numberLabel.font = [UIFont systemFontOfSize:12];
            _numberLabel.textColor = PlaceTextColor;
            _numberLabel.textAlignment = NSTextAlignmentRight;
            _numberLabel.text = [NSString stringWithFormat:@"0/%ld",(long)self.lengthMax];
            [self addSubview:_numberLabel];
        }
    }
    [self layoutGUI];
    [super drawRect:rect];
}


@end
