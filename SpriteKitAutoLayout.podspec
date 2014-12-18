Pod::Spec.new do |s|
  s.name             = "SpriteKitAutoLayout"
  s.version          = "0.1.0"
  s.summary          = "Auto Layout support for SpriteKit (iOS & OSX)"
  s.description      = <<-DESC
                       This library enables Auto Layout support for SpriteKit.
                       Works both for iOS and OSX.

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/mgrebenets/SpriteKitAutoLayout"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Maksym Grebenets" => "mgrebenets@gmail.com" }
  s.source           = { :git => "https://github.com/mgrebenets/SpriteKitAutoLayout.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mgrebenets'

  # all platforms, so no s.platform here
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.public_header_files = ['Pod/Classes/**/*.h']
  s.private_header_files = ['Pod/Classes/**/*Internal*.h']
  s.frameworks = 'SpriteKit'
#s.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS[config=Debug]' => '$(inherited) SKAL_DEBUG=1' }
end
