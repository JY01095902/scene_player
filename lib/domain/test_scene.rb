require "minitest/autorun"
require "minitest/hooks/default"
require_relative "scene.rb"
require_relative "../infra/cmd_keywords.rb"
require_relative "../infra/os.rb"

cmd_keywords = CMDKeywordsFactory.get_cmd_keywords(os())
cd = cmd_keywords[:cd]
cp = cmd_keywords[:cp]
rm = cmd_keywords[:rm]

describe Scene do
  include Minitest::Hooks

  before(:all) do
    Dir.mkdir("#{Dir.pwd}/lib/domain/test") unless File.directory? ("#{Dir.pwd}/lib/domain/test")
    File.new("#{Dir.pwd}/test.toml","w+") unless File.directory? ("#{Dir.pwd}/test.toml")
    File.new("#{Dir.pwd}/test2.toml","w+") unless Dir.exist? ("#{Dir.pwd}/test.toml")

    name = 'test'
    place = '~/lib/domain/test'
    props = [
      "test.toml",
      "test2.toml"
    ]
    actions = [
      "#{cp} test.toml test_copy.toml",
      "#{cp} test2.toml test2_copy.toml"
    ]
    @scene = Scene.new(name, place, props, actions)
  end
  
  after(:all) do
    File.delete("#{Dir.pwd}/test.toml") if File.exist? "#{Dir.pwd}/test.toml"
    File.delete("#{Dir.pwd}/test2.toml") if File.exist? "#{Dir.pwd}/test2.toml"
    File.delete("#{Dir.pwd}/lib/domain/test/test_copy.toml") if File.exist? "#{Dir.pwd}/lib/domain/test/test_copy.toml"
    File.delete("#{Dir.pwd}/lib/domain/test/test2_copy.toml") if File.exist? "#{Dir.pwd}/lib/domain/test/test2_copy.toml"
    Dir.rmdir("#{Dir.pwd}/lib/domain/test") if File.directory? ("#{Dir.pwd}/lib/domain/test")
  end

  describe "测试go_to_place" do
    expect_act = ["#{cd} #{Dir.pwd}/lib/domain/test"]
    it "跳转目录命令应该为#{expect_act}" do
      @scene.go_to_place
      _(@scene.commands).must_equal expect_act
    end
  end

  describe "测试load_props" do
    expect_act = [
      "#{cp} #{Dir.pwd}/test.toml #{Dir.pwd}/lib/domain/test/test.toml",
      "#{cp} #{Dir.pwd}/test2.toml #{Dir.pwd}/lib/domain/test/test2.toml"
    ]
    it "复制命令应该为#{expect_act}" do
      @scene.load_props
      _(@scene.commands).must_equal expect_act
    end
  end

  describe "测试exec_actions" do
    expect_act = [
      "#{cp} test.toml test_copy.toml",
      "#{cp} test2.toml test2_copy.toml"
    ]
    it "执行命令应该为#{expect_act}" do
      @scene.exec_actions
      _(@scene.commands).must_equal expect_act
    end
  end

  describe "测试unload_props" do
    expect_act = [
      "#{rm} #{Dir.pwd}/lib/domain/test/test.toml",
      "#{rm} #{Dir.pwd}/lib/domain/test/test2.toml"
    ]
    it "删除命令应该为#{expect_act}" do
      @scene.unload_props
      _(@scene.commands).must_equal expect_act
    end
  end

  describe "测试run" do
    expect_act = [
      "#{cd} #{Dir.pwd}/lib/domain/test",
      "#{cp} #{Dir.pwd}/test.toml #{Dir.pwd}/lib/domain/test/test.toml",
      "#{cp} #{Dir.pwd}/test2.toml #{Dir.pwd}/lib/domain/test/test2.toml",
      "#{cp} test.toml test_copy.toml",
      "#{cp} test2.toml test2_copy.toml",
      "#{rm} #{Dir.pwd}/lib/domain/test/test.toml",
      "#{rm} #{Dir.pwd}/lib/domain/test/test2.toml",
    ]
    it "commands应该为" do
      @scene.run
      _(@scene.commands).must_equal expect_act
    end

    it "~/lib/domain/test目录下应该有test_copy.toml和test2_copy.toml文件" do
      exist_test_copy = File::exist?("#{Dir.pwd}/lib/domain/test/test_copy.toml")
      exist_test2_copy = File::exist?("#{Dir.pwd}/lib/domain/test/test2_copy.toml")
      @scene.run
      _(exist_test_copy).must_equal true
      _(exist_test2_copy).must_equal true
    end
  end
end