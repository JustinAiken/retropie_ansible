class RetroPie
  class InvalidSystemError < ArgumentError; end

  ALL_SYSTEMS = %i{
    amiga apple2 atari2600 atari7800 atarilynx c64 dragon32 fba gamegear gba genesis macintosh mame-libretro mastersystem msx neogeo ngp pc ports psx scummvm segacd snes videopac wonderswancolor zxspectrum
    amstradcpc arcade atari5200 atari800 atarist coco dreamcast fds gb gbc intellivision mame-advmame mame-mame4all megadrive n64 nes ngpc pcengine psp quake3 sega32x sg-1000 vectrex wonderswan zmachine
  }

  # Recommended = Carbon, Pixel, Eudora, Turtle-pi, and Canela variants
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

  def self.systems
    %i{gba megadrive nes sega32x snes}
  end

  def self.validate_system!(sys)
    return unless sys
    raise InvalidSystemError unless ALL_SYSTEMS.map(&:to_s).include?(sys) || ALL_SYSTEMS.include?(sys)
  end
end
