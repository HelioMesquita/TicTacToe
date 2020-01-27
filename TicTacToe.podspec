

Pod::Spec.new do |spec|
  spec.name         = "TicTacToe"
  spec.version      = "0.0.1"
  spec.summary      = "A baseline view over the application to help verify alignments"
  spec.description  = 'How many times have you had doubts if an element was aligned? or how many times did your designer say that something was not aligned? to prevent this problem this library inserts on your application baselines. So you can use the application while checking if the components are within the baselines'

  spec.homepage     = "https://github.com/HelioMesquita/TicTacToe"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  spec.license      = { :type => "MIT" }
  spec.author             = { "Helio Mesquita" => "helio.mesquitaios@gmail.com" }
  spec.social_media_url   = "https://www.linkedin.com/in/hélio-mesquita-b22950109/"\

  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/HelioMesquita/TicTacToe.git", :branch => "master", :tag => spec.version.to_s }
  spec.source_files = 'TicTacToe/Public/*.{h,m}', 'TicTacToe/Private/*.{h,m}'
  spec.private_header_files = 'TicTacToe/Private/*.h'
  spec.requires_arc = true

end
