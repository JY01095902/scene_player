

class CMDKeywordsFactory
  @windows_cmd_keywords = {
    cd: "cd",
    cp: "copy",
    rm: "del/s/q",
    and: "&"
  }

  @linux_cmd_keywords = {
    cd: "cd",
    cp: "cp",
    rm: "rm",
    and: "&&"
  }
  def self.get_cmd_keywords(os)
    case os
    when :windows
      @windows_cmd_keywords
    when :macosx
      @linux_cmd_keywords
    else
      nil
    end
  end
end