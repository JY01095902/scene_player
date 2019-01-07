require 'minitest/autorun'
require_relative '../lib/domain/scene.rb'

describe Scene do
    before do
        @name1 = "s1"
        @place1 = "playground1"
        @props1 = ["ball1"]
        @actions1 = ["run1", "tick one ball"]
        scene1 = {
            "name" => @name1,
            "place" => @place1,
            "props" => @props1,
            "actions" => @actions1
        }
        @name2 = "s2"
        @place2 = "playground2"
        @props2 = ["ball2"]
        @actions2 = ["run2", "tick two balls"]
        scene2 = {
            "name" => @name2,
            "place" => @place2,
            "props" => @props2,
            "actions" => @actions2
        }
        @scenes = Array.new
        @scenes.push(scene1, scene2)
    end

    describe "当Scene.get_scene(s1)时" do
        it '必须返回名称是s1，场地是playground1，道具是["ball1"]，动作是["run1", "tick one ball"]，' do
           scene = get_scene(@scenes, "s1")
           scene.name.must_equal @name1
           scene.place.must_equal @place1
           scene.props.must_equal @props1
           scene.actions.must_equal @actions1
        end
    end
end