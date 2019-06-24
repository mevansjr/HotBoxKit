Pod::Spec.new do |s|
  s.name                      = "HotBoxKit"
  s.version                   = "1.0.0"
  s.summary                   = "HotBoxKit"
  s.homepage                  = "https://github.com/MarkEvans/HotBoxKit"
  s.license                   = { :type => "MIT", :file => "LICENSE" }
  s.author                    = { "Mark Evans" => "mark@3advance.com" }
  s.source                    = { :git => "https://github.com/mevansjr/HotBoxKit.git", :tag => s.version.to_s }
  s.ios.deployment_target     = "11.0"
  s.source_files              = "Sources/**/*"
  s.frameworks                = "Foundation"

end
