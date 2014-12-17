#
# Be sure to run `pod lib lint SpriteKitAutoLayout.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SpriteKitAutoLayout"
  s.version          = "0.1.0"
  s.summary          = "TODO: A short description of SpriteKitAutoLayout."
  s.description      = <<-DESC
                       TODO: An optional longer description of SpriteKitAutoLayout

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/mgrebenets/SpriteKitAutoLayout"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Maksym Grebenets" => "mgrebenets@gmail.com" }
  s.source           = { :git => "https://github.com/mgrebenets/SpriteKitAutoLayout.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mgrebenets'

#s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.public_header_files = ['Pod/Classes/**/*.h']
  s.private_header_files = ['Pod/Classes/**/*Internal*.h']
  s.frameworks = 'SpriteKit'
end
