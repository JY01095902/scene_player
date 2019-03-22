require "toml"
require_relative "domain/scene.rb"
require "pp"

def run(scene_name)
    if scene_name == "-v"
        puts "0.0.3"
        return
    end

    dir_pwd = Dir.pwd
    filepath = File.join(dir_pwd, 'playbook.toml')
    playbook = TOML.load_file(filepath)
    scenes = playbook["scenes"]
    
    scene = get_scene(scenes, scene_name)
    if !scene.is_a?(Scene)
        puts "没有名称为#{scene_name}的场景"
    else
        place = scene.place
        place = (place.start_with? "~") ? dir_pwd + place[1..-1] : place
        goToPlace = "cd #{place}"
        actions = scene.actions
        commands = Array.new
        props = scene.props
        if props.nil?
            commands.push(goToPlace).concat(actions)
        else
            placeProps = Array.new
            cleanProps = Array.new
            for prop in props
                placeProps.push("cp #{File.join(dir_pwd, prop)} #{place}/#{prop}")
                cleanProps.push("rm #{prop}")
            end
            commands.push(placeProps, goToPlace).concat(actions).push(cleanProps)
        end
        act = commands.join(" && ")
        system act
    end
end