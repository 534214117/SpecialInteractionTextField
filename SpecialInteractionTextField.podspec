@version = "0.0.3"

Pod::Spec.new do |s|
    s.name         = "SpecialInteractionTextField"
    s.version      = @version
    s.summary      = "增强交互的TextField."
    s.description  = <<-DESC
                        First upload
                        *Hope to succeed
                        DESC
    s.homepage     = "https://github.com/534214117/SpecialInteractionTextField"
    s.license      = "MIT"
    s.author             = { "Sonia" => "534214117@qq.com" }
    s.platform     = :ios, "10.0"
    s.source       = { :git => "https://github.com/534214117/SpecialInteractionTextField.git",:tag => "v#{s.version}" }
    s.source_files  = "SpecialInteractionTextField/**/*.{h,m}"
    s.framework  = "UIKit", "Foundation"
    s.requires_arc = true
    s.dependency "pop"

end
