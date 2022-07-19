
import SwiftUI

extension Font {
    
    struct Nunito {
        
        /// Get NunitoSans-ExtraBold with a size
        /// - Parameter size: The size of the font
        /// - Returns: A font to apply onto a view
        static func extraBold(size: CGFloat) -> Font {
            .custom("Roboto-Mono-Bold", size: size)
        }
        
        /// Get NunitoSans-Bold with a size
        /// - Parameter size: The size of the font
        /// - Returns: A font to apply onto a view
        static func bold(size: CGFloat) -> Font {
            .custom("Roboto-Bold", size: size)
        }
        
        /// Get NunitoSans-SemiBold with a size
        /// - Parameter size: The size of the font
        /// - Returns: A font to apply onto a view
        static func semiBold(size: CGFloat) -> Font {
            .custom("Roboto-Mono-Thin", size: size)
        }
        
        /// Get NunitoSans-Regular with a size
        /// - Parameter size: The size of the font
        /// - Returns: A font to apply onto a view
        static func regular(size: CGFloat) -> Font {
            .custom("Roboto-Regular", size: size)
        }
        
        
    }
    
    struct Muli{
        
        static func muli(size: CGFloat) -> Font {
            .custom("Muli-regular", size: size)
        }

    }
}
