
namespace :app do

  task :test do
  end

  task :build do
    # if u want to build/compile using system elixir pkg, 
    # then u need to remove github elixir dependency from
    # priv/emq_housing_build/plugins.mk and add the line below
    #
    #
    # sh "ln -sf /usr/lib/elixir -T deps/elixir"
    #
    # also add elixir to pkgs.yml under build_pkgs
    sh "./build.sh"
    archive "emq-relx", gnu_tar: true do
      add "_rel"
      #For checking the config through which release was generated.
      add "relx.config"
      add "vars.config"
      add_bundle
    end
  end

  task "deploy:git" do
    sh "./build.sh"
    sh "sv rr"
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
