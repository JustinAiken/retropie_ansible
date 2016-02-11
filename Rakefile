require_relative 'lib/systems.rb'
require_relative 'lib/ansible_tool.rb'
require_relative 'lib/get_arg.rb'

namespace :pi do
  desc "Config the common bits"
  task :restart do
    Ansible.playbook tags: ['restart']
  end

  desc "Config the common bits"
  task :config do
    Ansible.playbook tags: ['config']
  end

  desc "Set up controller config"
  task :config_controllers do
    Ansible.playbook tags: ['controllers']
  end

  desc "Update retropie-setup"
  task :update do
    Ansible.playbook tags: ['update']
  end

  desc "Enables the requested system"
  task :enable do
    Ansible.playbook sys: get_arg, tags: ['enable']
  end
  desc "Disables the requested system"
  task :disable do
    Ansible.playbook sys: get_arg, tags: ['disable']
  end

  namespace :roms do
    SYSTEMS.each do |sys|
      desc "Install #{sys} roms"
      task sys do
        Ansible.playbook tags: 'roms', load_roms: true, sys: sys
      end
    end

    desc "Install all roms for all systems"
    task :all do
      SYSTEMS.each { |sys| Ansible.playbook tags: 'roms', load_roms: true, sys: sys }
    end
  end

  namespace :scraped do
    %i{pull push}.each do |direction|
      namespace direction do
        SYSTEMS.each do |sys|
          desc "#{direction} #{sys} gamelist/images"
          task sys do
            Ansible.playbook tags: 'scraped', direction: direction, sys: sys
          end
        end

        desc "#{direction} ALL gamelist/images"
        task :all do
          SYSTEMS.each { |sys| Ansible.playbook tags: 'scraped', direction: direction, sys: sys }
        end
      end
    end
  end

  namespace :bios do
    desc "Install all bioses"
    task :install do
      Ansible.playbook tags: ['bios']
    end
  end
end
