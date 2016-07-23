module IdonethisCli
  class Settings
    def oauth2_token
      settings['oauth2_token']
    end

    def team
      settings['team']
    end


    def settings
      file = "#{Dir.home}/.idonethis"

      if File.exist?(file)
        JSON.parse(File.read(file))
      else
        {}
      end
    end

    def set_team(team)
      settings = {
        "team" => team
      }
      save_settings(settings)
    end

    def save_settings(new_settings)
      file = "#{Dir.home}/.idonethis"

      settings = self.settings.merge(new_settings)

      File.open(file,"w") do |f|
        f.write(settings.to_json)
      end
    end

    def save_oauth2_token(opts)
      settings = { oauth2_token: opts }
      save_settings(settings)
    end

  end
end
