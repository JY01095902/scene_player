require 'minitest/autorun'
require_relative '../lib/domain/scene.rb'

describe Scene do
    before do
        @name = "s1"
        @place = "playground"
        @props = ["ball"]
        @actions = ["run", "tick ball"]
        @scene = Scene.new(@name, @place, @props, @actions)
    end

    describe "当描述场景内容的时候" do
        it '必须返回名称是s1，场地是s1，道具是["ball"]，动作是["run", "tick ball"]，' do
            @scene.describe.must_equal "name is #{@name},place is #{@place},props are #{@props},actions are #{@actions}"
        end
    end
end