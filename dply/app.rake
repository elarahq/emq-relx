
namespace :app do

  task :test do
  end

  task :build do
    # if u want to build/compile using system elixir pkg, 
    # then u need to remove github elixir dependency from
    # emqttd_plugin_housing/rebar.config and add this line
    #
    #
    # sh "ln -sf /usr/lib/elixir -T deps/elixir"
    #
    # also add elixir to pkgs.yml under build_pkgs
    sh "make"
    archive "emq-relx", git: false do
      add "rel"
      add "pkgs.yml"
      add "Gemfile"
      add "Gemfile.lock"
      add "dply"
      add "_rel"
      add "data"
      add_bundle
    end
  end

  task "deploy:git" do
    
  end

  task "deploy:archive" do
    sh "sv rr"
  end

  task :reload do
    sh "sv rr"
  end

  task :reopen_logs do
    sh "sv reopen_logs"
  end

  task :stop do
    sh "sv stop"
  end
  
end
