Gem::Specification.new do |s|
    s.name        = 'scene_player'
    s.version     = '0.0.5'
    s.date        = '2019-03-22'
    s.summary     = "Scene Player!"
    s.description = "A simple hello world gem"
    s.authors     = ["Shi Yanxun"]
    s.email       = 'jy01095902@126.com'
    s.files       = ["lib/main.rb", "lib/scene_player.rb", "lib/domain/scene.rb"]
    s.homepage    =
      'http://rubygems.org/gems/scene_player'
    s.license       = 'MIT'
    s.executables << 'act'
    s.add_runtime_dependency 'pp', '~> 0.0', '>= 0.1.1'
    s.add_runtime_dependency 'toml', '~> 0.0', '>= 0.2.0'
  end