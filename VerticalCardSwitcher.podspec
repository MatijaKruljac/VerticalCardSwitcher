#
# Be sure to run `pod lib lint VerticalCardSwitcher.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VerticalCardSwitcher'
  s.version          = '0.1.1'
  s.summary          = 'VerticalCardSwitcher is library that provides UI list of cards which can be iterated by swiping up and down.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
VerticalCardSwitcher is inspired by Shazam Discover view. It is a vertical sequence of UIViews where first UIView in sequence is always displayed and every next UIView is partially displayed. Also there is VerticalCardSwitcherDelegate which is added for VerticalCardSwitcher customization. VerticalCardSwitcher is not implemented with UICollectionView and it's contained inside parent view.
                       DESC

  s.homepage         = 'https://github.com/MatijaKruljac/VerticalCardSwitcher'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kruljac.matija@gmail.com' => 'kruljac.matija@gmail.com' }
  s.source           = { :git => 'https://github.com/MatijaKruljac/VerticalCardSwitcher.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'VerticalCardSwitcher/Classes/**/*'
  
  # s.resource_bundles = {
  #   'VerticalCardSwitcher' => ['VerticalCardSwitcher/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
