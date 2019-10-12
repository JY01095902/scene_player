
require_relative "../infra/cmd_keywords.rb"
require_relative "../infra/os.rb"

class Scene
    attr_reader :name, :place, :props, :actions, :commands, :absolute_place
    def initialize(name, place, props, actions)
        @name = name
        @place = place
        @props = props
        @actions = actions
        @cmd_keywords = CMDKeywordsFactory.get_cmd_keywords(os())
        @commands = []
        @absolute_place = (@place.start_with? "~") ? Dir.pwd + @place[1..-1] : @place
    end

    def run
        go_to_place
        load_props
        exec_actions
        unload_props

        join = @cmd_keywords[:and]
        act = @commands.join(" #{join} ")
        system act
    end

    # private
    def go_to_place
        cd = @cmd_keywords[:cd]
        @commands << "#{cd} #{@absolute_place}"
    end

    def load_props
        cp = @cmd_keywords[:cp]
        for prop in @props
            @commands << "#{cp} #{Dir.pwd}/#{prop} #{@absolute_place}/#{prop}"
        end
    end

    def exec_actions
        for action in @actions
            @commands << "#{action}"
        end
    end

    def unload_props
        rm = @cmd_keywords[:rm]
        for prop in props
            @commands << "#{rm} #{@absolute_place}/#{prop}"
        end
    end
end