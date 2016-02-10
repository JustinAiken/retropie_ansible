class Ansible
  class InvalidSystemError < ArgumentError; end

  def self.run(cmd)
    IO.popen "ANSIBLE_FORCE_COLOR=true #{cmd}" do |io|
      while (line = io.gets) do
        puts line
      end
    end
  end

  def self.playbook(tags: [], load_roms: false, direction: nil, sys: nil)
    raise InvalidSystemError if sys && !ALL_SYSTEMS.map(&:to_s).include?(sys)

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
end
