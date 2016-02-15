require 'json'

class RetroPie
  class InvalidSystemError < ArgumentError; end

  ALL_SYSTEMS = %i{
    amiga amstradcpc apple2 arcade atari2600 atari5200 atari7800 atari800 atarilynx atarist c64 coco dragon32 dreamcast
    fba fds gamegear gb gba gbc genesis intellivision macintosh mame-advmame mame-libretro mame-mame4all mastersystem
    megadrive msx n64 neogeo nes ngp ngpc pc pcengine ports psp psx quake3 scummvm sega32x segacd sg-1000 snes vectrex
    videopac wonderswan wonderswancolor zmachine zxspectrum
  }

  RECOMMENDED_THEMES = %w{carbon carbon-centered carbon-nometa pixel eudora eudora-bigshot eudora-concise turtle-pi retroplay-clean-canela retroplay-clean-detail-canela}
  THEMES = [
    {repo: 'AmadhiX',       theme: 'eudora'},
    {repo: 'AmadhiX',       theme: 'eudora-bigshot'},
    {repo: 'AmadhiX',       theme: 'eudora-concise'},
    {repo: 'HerbFargus',    theme: 'tronkyfran'},
    {repo: 'InsecureSpike', theme: 'retroplay-clean-canela'},
    {repo: 'InsecureSpike', theme: 'retroplay-clean-detail-canela'},
    {repo: 'Omnija',        theme: 'simpler-turtlepi'},
    {repo: 'robertybob',    theme: 'space'},
    {repo: 'robertybob',    theme: 'simplebigart'},
    {repo: 'RetroPie',      theme: 'carbon'},
    {repo: 'RetroPie',      theme: 'carbon-centered'},
    {repo: 'RetroPie',      theme: 'carbon-nometa'},
    {repo: 'RetroPie',      theme: 'pixel'},
    {repo: 'RetroPie',      theme: 'turtle-pi'},
    {repo: 'RetroPie',      theme: 'simple'},
    {repo: 'RetroPie',      theme: 'simple-dark'},
    {repo: 'RetroPie',      theme: 'color-pi'},
    {repo: 'RetroPie',      theme: 'simplified-static-canela'},
    {repo: 'RetroPie',      theme: 'zoid'},
    {repo: 'RetroPie',      theme: 'nbba'},
    {repo: 'RetroPie',      theme: 'clean-look'}
  ]

  def self.explicitly_disabled
    system_file['disabled']
  end

  def self.systems
    system_file['enabled']
  end

  def self.validate_system!(sys)
    return unless sys
    raise InvalidSystemError unless ALL_SYSTEMS.map(&:to_s).include?(sys) || ALL_SYSTEMS.include?(sys)
  end

  def self.system_file
    @system_file ||= begin
      _file = File.read('systems.json')
      JSON.parse _file
    end
  end
end
