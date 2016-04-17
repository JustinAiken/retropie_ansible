require_relative 'lib/retro_pie.rb'
require_relative 'lib/ansible_tool.rb'
require_relative 'lib/get_arg.rb'

namespace :pi do
  desc "Restart the pi"
  task :restart do
    Ansible.playbook 'restart'
  end

  desc "Quit current emulator"
  task :quit do
    Ansible.playbook 'quit'
  end

  desc "Config retropie"
  task :config do
    Ansible.playbook 'config', load_secrets: true
  end

  namespace :config do
    desc "Update retropie-setup"
    task :update do
      Ansible.playbook 'update'
    end

    desc "Set up controller config"
    task :controllers do
      Ansible.playbook 'controllers'
    end

    desc "Set up RetroArch config"
    task :retroarch do
      Ansible.playbook 'retroarch', load_secrets: true
    end
  end

  namespace :themes do
    desc "Install theme - provide in form of repo/theme"
    task :install do
      repo, theme = get_arg.split("/")
      Ansible.playbook 'theme', repo: repo, theme: theme
    end

    desc "Install ALL THE themes!"
    task :install do
      RetroPie::THEMES.each { |t| Ansible.playbook 'theme', repo: t[:repo], theme: t[:theme] }
    end

    desc "Install all recommended themes"
    task :recommended do
      RetroPie::THEMES.each do |t|
        next unless RetroPie::RECOMMENDED_THEMES.include?(t[:theme])
        Ansible.playbook 'theme', repo: t[:repo], theme: t[:theme]
      end
    end
  end

  namespace :roms do
    RetroPie.systems.each do |sys|
      desc "Install #{sys} roms"
      task sys do
        Ansible.playbook 'roms', load_roms: true, system: sys
      end
    end

    desc "Install all roms for all systems"
    task :all do
      RetroPie.systems.each { |sys| Ansible.playbook 'roms', load_roms: true, system: sys }
    end
  end

  namespace :scraped do
    %i{pull push}.each do |direction|
      namespace direction do
        RetroPie.systems.each do |sys|
          desc "#{direction} #{sys} gamelist/images"
          task sys do
            Ansible.playbook 'scraped', direction: direction, system: sys
          end
        end

        desc "#{direction} ALL gamelist/images"
        task :all do
          RetroPie.systems.each { |sys| Ansible.playbook 'scraped', direction: direction, system: sys }
        end
      end
    end
  end

  namespace :bios do
    desc "Install all bioses"
    task :install do
      Ansible.playbook 'bios'
    end
  end

  desc "Full restore"
  task :restore do
    Rake::Task["pi:config:update"].invoke
    Rake::Task["pi:config"].invoke
    Rake::Task["pi:config:controllers"].invoke
    Rake::Task["pi:config:retroarch"].invoke
    Rake::Task["pi:disable_all"].invoke
    Rake::Task["pi:roms:all"].invoke
    Rake::Task["pi:bios:install"].invoke
    Rake::Task["pi:scraped:push:all"].invoke
    Rake::Task["pi:themes:recommended"].invoke
  end

  desc "Full backup"
  task :backup do
    Rake::Task["pi:scraped:pull:all"].invoke
  end
end
