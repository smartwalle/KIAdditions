//
//  NSLayoutConstraint+KIAdditions.m
//  Kitalker
//
//  Created by 杨烽 on 14/11/20.
//
//

#import "NSLayoutConstraint+KIAdditions.h"
#import <objc/runtime.h>

@implementation NSLayoutConstraint (KIAdditions)

@end

static char KI_VIEW_CONSTRAINT_KEY;

@implementation UIView (NSLayoutConstraint)

- (void)ki_setConstraintValue:(CGFloat)value forAttribute:(NSLayoutAttribute)attribute {
    
    NSMutableDictionary *items = objc_getAssociatedObject(self, &KI_VIEW_CONSTRAINT_KEY);

    if (items == nil) {
        items = [[NSMutableDictionary alloc] init];
    }
    
    [items setObject:@(value) forKey:@(attribute)];
    
    objc_setAssociatedObject(self, &KI_VIEW_CONSTRAINT_KEY, items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGFloat)ki_constraintWithAttribute:(NSLayoutAttribute)attribute {
    
    NSMutableDictionary *items = objc_getAssociatedObject(self, &KI_VIEW_CONSTRAINT_KEY);
    
    NSNumber *value = [items objectForKey:@(attribute)];
    if (value == nil) {
        value = @(0);
    }
    return [value floatValue];
}


- (void)setConstraintConstant:(CGFloat)constant forAttribute:(NSLayoutAttribute)attribute {
    NSLayoutConstraint *constraint = [self constraintForAttribute:attribute];
    if (constraint) {
        [constraint setConstant:constant];
    } else {
        constraint = [NSLayoutConstraint constraintWithItem:self
                                                  attribute:attribute
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                 multiplier:1.0f
                                                   constant:constant];
        [self.superview addConstraint:constraint];
    }
}

- (CGFloat)constraintConstantForAttribute:(NSLayoutAttribute)attribute {
    NSLayoutConstraint *constraint = [self constraintForAttribute:attribute];
    if (constraint) {
        return constraint.constant;
    }
    return NAN;
}

- (NSLayoutConstraint *)constraintForAttribute:(NSLayoutAttribute)attribute {
    NSPredicate *predicat = [NSPredicate predicateWithFormat:@"firstAttribute = %d && firstItem = %@", attribute, self];
    NSArray *results = [[self.superview constraints] filteredArrayUsingPredicate:predicat];
    
    if (results.count == 0) {
        results = [[self constraints] filteredArrayUsingPredicate:predicat];
    }
    
    if (results.count > 0) {
        return results.firstObject;
    }
    return nil;
}

- (void)hideByHeight:(BOOL)hidden {
    [self hideView:hidden byAttribute:NSLayoutAttributeHeight];
}

- (void)hideByWidth:(BOOL)hidden {
    [self hideView:hidden byAttribute:NSLayoutAttributeWidth];
}

- (void)hideView:(BOOL)hidden byAttribute:(NSLayoutAttribute)attribute {
    if (self.hidden != hidden) {
        CGFloat constant = [self constraintConstantForAttribute:attribute];
        if (hidden) {
            
            CGFloat value = constant;
            
            if (isnan(value)) {
                CGSize size = [self ki_layoutSize];
                value = (attribute == NSLayoutAttributeHeight) ? size.height:size.width;
            }
            
            [self ki_setConstraintValue:value forAttribute:attribute];
            
            [self setConstraintConstant:0 forAttribute:attribute];
            
            [self setHidden:YES];
        } else {
            if (!isnan(constant)) {
                CGFloat value = [self ki_constraintWithAttribute:attribute];
                
                if (isnan(value)) {
                    value = 0;
                }
                
                [self setConstraintConstant:value forAttribute:attribute];
                
                [self setHidden:NO];
            }
        }
    }
}

- (CGSize)ki_layoutSize {
    [self ki_updateLayoutSizes];
    return CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (void)ki_updateLayoutSizes {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)ki_sizeToSubviews {
    [self ki_updateLayoutSizes];
    CGSize fittingSize = [self systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
    self.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), fittingSize.height);
}

@end
