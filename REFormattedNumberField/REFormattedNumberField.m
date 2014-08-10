//
// REFormattedNumberField.m
// REFormattedNumberField
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "REFormattedNumberField.h"

@interface REFormattedNumberField ()

@property (copy, readwrite, nonatomic) NSString *currentFormattedText;
@property (weak, readwrite, nonatomic) id<UITextFieldDelegate> originalDelegate;

@end

@implementation REFormattedNumberField

- (void)commonInit
{
    self.keyboardType = UIKeyboardTypeNumberPad;
    self.format = @"X";

    [super setDelegate:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:(CGRect)frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self commonInit];
}

- (NSString *)string:(NSString *)string withNumberFormat:(NSString *)format
{
    if (!string)
        return @"";
    return [string re_stringWithNumberFormat:format];
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    self.originalDelegate = delegate;
}

- (id<UITextFieldDelegate>)delegate
{
    return self.originalDelegate;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([self.originalDelegate respondsToSelector:aSelector]) {
        return self.originalDelegate;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL respondsToSelector = [super respondsToSelector:aSelector];

    if (!respondsToSelector) {
        respondsToSelector = [self.originalDelegate respondsToSelector:aSelector];
    }
    return respondsToSelector;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (![string length] && range.length == 1) {
        range = [self decimalRangeWithRange:range];
    }

    if ([self.originalDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {

        if (![self.originalDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string]) {
            return NO;
        }
    }

    NSString *unformattedText = [self unformattedText];
    NSRange unformatedTextRange = [self unformattedTextRangeWithRange:range];

    NSString *text = [unformattedText stringByReplacingCharactersInRange:unformatedTextRange withString:string];
    self.text = [text re_stringWithNumberFormat:self.format];

    [self sendActionsForControlEvents:UIControlEventEditingChanged];

    return NO;
}

#pragma mark - Private methods

- (NSRange)unformattedTextRangeWithRange:(NSRange)range
{
    NSRange unformattedTextRange = NSMakeRange(0, 0);

    for (NSInteger i = 0; i < range.location; ++i) {
        if ([self.format characterAtIndex:i] == 'X') {
            ++unformattedTextRange.location;
        }
    }

    for (NSInteger i = range.location; i < (range.location + range.length); ++i) {
        if ([self.format characterAtIndex:i] == 'X') {
            ++unformattedTextRange.length;
        }
    }

    return unformattedTextRange;
}

- (NSRange)decimalRangeWithRange:(NSRange)range
{
    NSRange decimalRange = range;

    for (NSInteger i = range.location + range.length - 1; i > 0; i--) {
        NSString *c = [self.format substringWithRange:NSMakeRange(i, 1)];

        if ([c isEqualToString:@"X"]) {

            decimalRange.location = i;
            decimalRange.length = (range.location + range.length) - i;

            break;
        }
    }

    return decimalRange;
}

- (NSString *)unformattedText
{
    if (!self.format) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\D" options:NSRegularExpressionCaseInsensitive error:NULL];
        return [regex stringByReplacingMatchesInString:self.text options:0 range:NSMakeRange(0, self.text.length) withTemplate:@""];
    }
    NSString *trimmedFromat = [[self.format componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789X"] invertedSet]] componentsJoinedByString:@""];
    NSString *trimmedText = [[self.text componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];

    NSMutableString *unformattedText = [NSMutableString string];
    NSUInteger length = MIN([trimmedFromat length], [trimmedText length]);

    for (NSUInteger i = 0; i < length; ++i) {
        NSRange range = NSMakeRange(i, 1);

        NSString *symbol = [trimmedText substringWithRange:range];
        if (![[trimmedFromat substringWithRange:range] isEqualToString:symbol]) {
            [unformattedText appendString:symbol];
        }
    }

    return [unformattedText copy];
}

@end
