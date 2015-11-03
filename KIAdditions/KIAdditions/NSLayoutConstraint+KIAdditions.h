//
//  NSLayoutConstraint+KIAdditions.h
//  Kitalker
//
//  Created by 杨烽 on 14/11/20.
//
//

#import <UIKit/UIKit.h>

/*Layout constraint*/
#define KILayoutConstraint(item1, att1, relation, item2, att2, m, c) [NSLayoutConstraint constraintWithItem:item1 \
    attribute:att1 \
    relatedBy:relation\
    toItem:item2 \
    attribute:att2 \
    multiplier:m \
    constant:c]

@interface NSLayoutConstraint (KIAdditions)

@end

@interface UIView (NSLayoutConstraint)

- (void)setConstraintConstant:(CGFloat)constant forAttribute:(NSLayoutAttribute)attribute;

- (CGFloat)constraintConstantForAttribute:(NSLayoutAttribute)attribute;

- (NSLayoutConstraint *)constraintForAttribute:(NSLayoutAttribute)attribute;

- (void)hideByHeight:(BOOL)hidden;

- (void)hideByWidth:(BOOL)hidden;

- (void)hideView:(BOOL)hidden byAttribute:(NSLayoutAttribute)attribute;

@end