#
# Be sure to run `pod lib lint StackLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "StackLayout"
  s.version          = "0.9.0"
  s.summary          = "An more flexible alternative to UIStackView."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                       Create Auto Layout constraints to layout views in stack. Alternative to UIStackView which supports multiple different layouts in a single view. Also includes helpful shortcuts for creating NSLayoutConstraints.
                       DESC

  s.homepage         = "https://github.com/bridger/StackLayout"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Bridger Maxwell" => "bridger.maxwell@gmail.com" }
  s.source           = { :git => "https://github.com/bridger/StackLayout.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/bridgermax'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/StackLayout/**/*'
  s.resource_bundles = {
    'StackLayout' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
