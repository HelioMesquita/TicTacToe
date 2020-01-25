

Pod::Spec.new do |spec|
  spec.name         = "TicTacToe"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of TicTacToe."
  spec.description  = "A short description of TicTacToe."

  spec.homepage     = "https://github.com/HelioMesquita/TicTacToe"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  spec.license      = { :type => "MIT" }
  spec.author             = { "Helio Mesquita" => "helio.mesquitaios@gmail.com" }
  # spec.social_media_url   = "https://twitter.com/Helio Mesquita"\

  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/HelioMesquita/TicTacToe.git", :branch => "master", :tag => spec.version.to_s }
  spec.source_files  = "TicTacToe/*.{h,m}"
  spec.requires_arc = true
  spec.public_header_files = "TicTacToe/*.h"

end
