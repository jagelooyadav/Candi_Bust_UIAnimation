
import UIKit
class CandiScreenTransitioner: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 0.5
    var presenting = true
    var originFrame = CGRect.zero
    
    var dismissCompletion: (() -> Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = !presenting ? transitionContext.view(forKey: .from)! : transitionContext.view(forKey: .to)!
        let recipeView = presenting ? toView : transitionContext.view(forKey: .from)!
        
        if presenting {
            toView.alpha = 0.0
            recipeView.alpha = 0.0
        } else {
            toView.alpha = 1.0
            recipeView.alpha = 1.0
        }
   
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(recipeView)
        recipeView.isHidden = true
        recipeView.setNeedsDisplay()
        UIView.animateKeyframes(withDuration: 0.5,
                                delay: 0.0,
                                options: UIView.KeyframeAnimationOptions.allowUserInteraction) {
            toView.alpha = 1.0
            recipeView.alpha = 1.0
            
            if self.presenting {
                toView.alpha = 1.0
                recipeView.alpha = 1.0
                recipeView.isHidden = false
            } else {
                toView.alpha = 0.0
                recipeView.alpha = 0.0
                recipeView.isHidden = true
            }
        } completion: { _ in
            if !self.presenting {
                self.dismissCompletion?()
            }
            transitionContext.completeTransition(true)
        }
    }
}
