

Pod::Spec.new do |spec|
  spec.name         = "TicTacToe"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of TicTacToe."
  spec.description  = ""

  spec.homepage     = "http://EXAMPLE/TicTacToe"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  spec.license      = { :type => "MIT" }
  spec.author             = { "Helio Mesquita" => "helio.mesquitaios@gmail.com" }
  # spec.social_media_url   = "https://twitter.com/Helio Mesquita"

  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/HelioMesquita/TicTacToe.git", :tag => "#{spec.version}" }
  spec.source_files  = "TicTacToe", "TicTacToe/**/*.{h,m}"
  spec.requires_arc = true

end
