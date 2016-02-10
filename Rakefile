ALL_SYSTEMS = %i{
  amiga apple2 atari2600 atari7800 atarilynx c64 dragon32 fba gamegear gba genesis macintosh mame-libretro mastersystem msx neogeo ngp pc ports psx scummvm segacd snes videopac wonderswancolor zxspectrum
  amstradcpc arcade atari5200 atari800 atarist coco dreamcast fds gb gbc intellivision mame-advmame mame-mame4all megadrive n64 nes ngpc pcengine psp quake3 sega32x sg-1000 vectrex wonderswan zmachine
}

SYSTEMS = %i{nes snes}

namespace :pi do
  desc "Config the common bits"
  task :restart do
    playbook tags: ['restart']
  end

  desc "Config the common bits"
  task :config do
    playbook tags: ['config']
  end

  desc "Set up controller config"
  task :config_controllers do
    playbook tags: ['controllers']
  end

  desc "Enables the requested system"
  task :enable do
    playbook sys: get_arg, tags: ['enable']
  end
  desc "Disables the requested system"
  task :disable do
    playbook sys: get_arg, tags: ['disable']
  end

  namespace :roms do
    SYSTEMS.each do |sys|
      desc "Install #{sys} roms"
      task sys do
        playbook tags: 'roms', load_roms: true, sys: sys
      end
    end

    desc "Install all roms for all systems"
    task :all do
      SYSTEMS.each { |sys| playbook tags: 'roms', load_roms: true, sys: sys }
    end
  end

  namespace :scraped do
    %i{pull push}.each do |direction|
      namespace direction do
        SYSTEMS.each do |sys|
          desc "#{direction} #{sys} gamelist/images"
          task sys do
            playbook tags: 'scraped', direction: direction, sys: sys
          end
        end

        desc "#{direction} ALL gamelist/images"
        task :all do
          SYSTEMS.each { |sys| playbook tags: 'scraped', direction: direction, sys: sys }
        end
      end
    end
  end

  namespace :bios do
    desc "Install all bioses"
    task :install do
      playbook tags: ['bios']
    end
  end
end

def run(cmd)
  IO.popen "ANSIBLE_FORCE_COLOR=true #{cmd}" do |io|
    while (line = io.gets) do
      puts line
    end
  end
end

def get_arg
  ARGV.each { |a| task a.to_sym do ; end }
  ARGV[1]
end

def playbook(tags: [], load_roms: false, direction: nil, sys: nil)
  cmd  = %Q{ANSIBLE_FORCE_COLOR=true ansible-playbook}
  cmd += %Q{ -i retropie,}
  cmd += %Q{ playbook.yml}
  cmd += %Q{ --tags "#{Array(tags).join ','}"}      if tags      != []
  cmd += %Q{ --extra-vars "@roms.json"}             if load_roms
  cmd += %Q{ --extra-vars "direction=#{direction}"} if direction
  cmd += %Q{ --extra-vars "system=#{sys}"}          if sys
  puts cmd
  run cmd
end
