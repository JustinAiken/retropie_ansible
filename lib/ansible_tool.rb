class Ansible

  def self.run(cmd)
    IO.popen "ANSIBLE_FORCE_COLOR=true #{cmd}" do |io|
      while (line = io.gets) do
        puts line
      end
    end
  end

  def self.playbook(tags, vars = {})
    RetroPie.validate_system!(vars[:system])
    load_roms  = vars.delete :load_roms
    extra_vars = vars.map { |k,v| "#{k.to_s}=#{v.to_s}" }.join " "

    cmd  = %Q{ANSIBLE_FORCE_COLOR=true ansible-playbook}
    cmd += %Q{ -i retropie,}
    cmd += %Q{ playbook.yml}
    cmd += %Q{ --tags "#{Array(tags).join ','}"} if tags != []
    cmd += %Q{ --extra-vars "@roms.json"}        if load_roms
    cmd += %Q{ --extra-vars "#{extra_vars}"}     if extra_vars != ''
    puts cmd
    run cmd
  end
end
