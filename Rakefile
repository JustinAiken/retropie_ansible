require_relative 'lib/retro_pie.rb'
require_relative 'lib/ansible_tool.rb'
require_relative 'lib/get_arg.rb'

namespace :pi do
  desc "Restart the pi"
  task :restart do
    Ansible.playbook 'restart'
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

  desc "Install theme - provide in form of repo/theme"
  task :theme do
    repo, theme = get_arg.split("/")
    Ansible.playbook 'theme', repo: repo, theme: theme
  end

  desc "Enables the requested system"
  task :enable do
    Ansible.playbook 'enable', system: get_arg
  end
  desc "Disables the requested system"
  task :disable do
    Ansible.playbook 'disable', system: get_arg
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
end
