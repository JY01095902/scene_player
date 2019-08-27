require "toml"
require_relative "domain/scene.rb"
require_relative "infra/os.rb"
require_relative "infra/cmd_keywords.rb"

def run(scene_name)
    if scene_name == "-v"
        puts "0.0.3"
        return
    end

    os = os()
    cmd_keywords = CMDKeywordsFactory.get_cmd_keywords(os)
    if cmd_keywords == nil 
        puts "暂不支持 #{os} 操作系统"
        return
    end
    cd = cmd_keywords[:cd]
    cp = cmd_keywords[:cp]
    rm = cmd_keywords[:rm]
    join = cmd_keywords[:and]

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
        goToPlace = "#{cd} #{place}"
        actions = scene.actions
        commands = Array.new
        props = scene.props
        if props.nil?
            commands.push(goToPlace).concat(actions)
        else
            placeProps = Array.new
            cleanProps = Array.new
            for prop in props
                placeProps.push("#{cp} #{File.join(dir_pwd, prop)} #{place}/#{prop}")
                cleanProps.push("#{rm} #{prop}")
            end
            commands.push(placeProps, goToPlace).concat(actions).push(cleanProps)
        end
        act = commands.join(" #{join} ")
        system act
    end
end