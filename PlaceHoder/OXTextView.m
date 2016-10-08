#import "OXTextView.h"

@implementation OXTextView

#pragma mark - Setters

- (void)setPlaceHolder:(NSString *)placeHolder {
    
    if([placeHolder isEqualToString:_placeHolder]) {
        return;
    }
    
    NSUInteger maxChars = [OXTextView maxCharactersPerLine];
    if([placeHolder length] > maxChars) {
        placeHolder = [placeHolder substringToIndex:maxChars - 8];
        placeHolder = [[placeHolder stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByAppendingFormat:@"..."];
    }
    
    _placeHolder = placeHolder;
    [self setNeedsDisplay];
}

- (void)setPlaceHolderTextColor:(UIColor *)placeHolderTextColor {
    
    if([placeHolderTextColor isEqual:_placeHolderTextColor]) {
        return;
    }
    
    _placeHolderTextColor = placeHolderTextColor;
    [self setNeedsDisplay];
}

#pragma mark - Message text view

- (NSUInteger)numberOfLinesOfText {
    
    return [OXTextView numberOfLinesForMessage:self.text];
}

+ (NSUInteger)maxCharactersPerLine {
    
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 33 : 109;
}

+ (NSUInteger)numberOfLinesForMessage:(NSString *)text {
    
    return (text.length / [OXTextView maxCharactersPerLine]) + 1;
}

#pragma mark - Text view overrides

- (void)setText:(NSString *)text {
    
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}

#pragma mark - Notifications

- (void)didReceiveTextDidChangeNotification:(NSNotification *)notification {
    [self setNeedsDisplay];
}

#pragma mark - Life cycle

- (void)setup {
    //No.1
    //开始写代码，添加一个通知，监听textview的内容是否改变
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
    
    //end_code
    
    _placeHolderTextColor = [UIColor lightGrayColor];
    
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.scrollIndicatorInsets = UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 8.0f);
    self.contentInset = UIEdgeInsetsZero;
    self.scrollEnabled = YES;
    self.scrollsToTop = NO;
    self.userInteractionEnabled = YES;
    self.font = [UIFont systemFontOfSize:16.0f];
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
    self.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.keyboardType = UIKeyboardTypeDefault;
    self.returnKeyType = UIReturnKeyDefault;
    self.textAlignment = NSTextAlignmentLeft;
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    
    _placeHolder = nil;
    _placeHolderTextColor = nil;
    //No.2
    //开始写代码，写出当该控件销毁时需要做的
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    
    //end_code
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    
    CGRect placeHolderRect = CGRectMake(10.0f,
                                        7.0f,
                                        rect.size.width,
                                        rect.size.height);
    //No.3
    //开始写代码，完善此方法，实现为textView添加placeholder功能
    
    
    if( [[self placeHolder] length] > 0 )
    
    {
        
        if ( _placeHolderLabel == nil )
            
        {
            
            _placeHolderLabel = [[UILabel alloc] initWithFrame:placeHolderRect];
            
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            _placeHolderLabel.numberOfLines = 0;
            
            _placeHolderLabel.font = self.font;
            
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            
            _placeHolderLabel.textColor = self.placeHolderTextColor;
            
            _placeHolderLabel.alpha = 0;
            
            _placeHolderLabel.tag = 999;
            
            [self addSubview:_placeHolderLabel];
            
        }
        
        
        
        _placeHolderLabel.text = self.placeHolder;
        
        [_placeHolderLabel sizeToFit];
        
        [self sendSubviewToBack:_placeHolderLabel];
        
    }
    
    
    
    if( [[self text] length] == 0 && [[self placeHolder] length] > 0 )
        
    {
        
        [[self viewWithTag:999] setAlpha:1];
        
    }
    
    
    
    [super drawRect:rect];
        
        
        //end_code
}

- (void)textChanged:(NSNotification *)notification

{
    
    if([[self placeHolder] length] == 0)
        
    {
        
        return;
        
    }
    
    
    
    if([[self text] length] == 0)
        
    {
        
        [[self viewWithTag:999] setAlpha:1];
        
    }
    
    else
        
    {
        
        [[self viewWithTag:999] setAlpha:0];
        
    }
    
}



@end