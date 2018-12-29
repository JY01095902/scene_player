
class Scene
    attr_reader :name, :place, :props, :actions
    def initialize(name, place, props, actions)
        @name = name
        @place = place
        @props = props
        @actions = actions
    end

    def describe() String
        return "name is #{@name},place is #{@place},props are #{@props},actions are #{@actions}"
    end
end

# def get_scene(scenes, name) Scene
#     for scene in scenes
#         scene_name = scene["name"]
#         if scene_name == name
#             return Scene.new(scene_name, scene["place"], scene["props"], scene["actions"])
#         end
#     end
# end