module LimitlessLed
  class Bridge
    include Colors
    attr_accessor :host, :port

    def initialize(host: 'localhost', port: 8899)
      @host = host
      @port = port
    end

    def group(number)
      LimitlessLed::Group.new(number, self)
    end

    def socket
      @socket ||= begin
        UDPSocket.new.tap do |socket|
          socket.connect host, port
        end
      end
    end

    def white
      send_packet "\xc2\x00\x55"
    end

    def color(color)
      color_code = if color.is_a?(Color::RGB)
         color_code_from_color(color)
       elsif color.is_a?(Integer)
         color
       elsif color.is_a?(String)
         color_code_from_color Color::RGB.const_get(color.camelize)
       end

      command :color, color_code
    end

    def brightness(amount)
      raise(ArgumentError.new('Brightness must be within 2 - 27')) unless (2..27).include?(amount)
      command :brightness, amount
    end

    def send_packet(packet)
      socket.send packet, 0
    end

    def command(command_key, command_param = 0)
      send_packet self.class::COMMANDS[command_key].chr + command_param.chr + 85.chr
    end

    def go_crazy
      while true
        color rand(256)
      end
    end

    def smooth_and_fast
      0..255.cycle do |color_code|
        color color_code
        sleep 1/100.0
      end
    end
  end

  class RGBW < Bridge
    COMMANDS = {
      all_off: 65,
      all_on: 66,
      disco: 77,
      disco_slower: 67,
      disco_faster: 68,
      color: 64,
      brightness: 78,
      group_1_on: 69,
      group_1_off: 70,
      group_2_on: 71,
      group_2_off: 72,
      group_3_on: 73,
      group_3_off: 74,
      group_4_on: 75,
      group_4_off: 76
    }

    COMMANDS.each do |cmd, _|
      next if cmd == :color || cmd == :brightness

      define_method(cmd) { command cmd }
    end

    def color(color)
      color_code = if color.is_a?(Color::RGB)
         color_code_from_color(color)
       elsif color.is_a?(Integer)
         color
       elsif color.is_a?(String)
         color_code_from_color Color::RGB.const_get(color.camelize)
       end

      command :color, color_code
    end


  end

  class White < Bridge
    COMMANDS = {
      all_off: 0x39,
      all_on: 0x35,
      brightness_up: 0x3c,
      brightness_down: 0x34,
      all_brightness_max: 0xb5,
      all_night_mode: 0xbb,
      warm_increase: 0x3e,
      cool_increase: 0x3f,
      group_1_on: 0x38,
      group_1_off: 0x3b,
      group_2_on: 0x3d,
      group_2_off: 0x33,
      group_3_on: 0x37,
      group_3_off: 0x3a,
      group_4_on: 0x32,
      group_4_off: 0x36,
      group_1_brightness_max: 0xb8,
      group_1_night_mode: 0xbb,
      group_2_brightness_max: 0xbd,
      group_2_night_mode: 0xb3,
      group_3_brightness_max: 0xb7,
      group_3_night_mode: 0xba,
      group_4_brightness_max: 0xb2,
      group_4_night_mode: 0xb6
    }

    GROUPS = [
      'group_1',
      'group_2',
      'group_3',
      'group_4'
    ]

    COMMANDS.each do |cmd, _|
      define_method(cmd) {
        command cmd
      }
    end

    GROUPS.each do |grp|
      define_method("#{grp}_brightness_min".to_sym) {
        send("#{grp}_on".to_sym)
        brightness_min
      }
    end

    GROUPS.each do |grp|
      define_method("#{grp}_brightness_up".to_sym) {
        send("#{grp}_on".to_sym)
        brightness_up
      }
    end

    GROUPS.each do |grp|
      define_method("#{grp}_brightness_down".to_sym) {
        brightness_down
      }
    end

    GROUPS.each do |grp|
      define_method("#{grp}_warm".to_sym) {
        warm_increase
      }
    end

    GROUPS.each do |grp|
      define_method("#{grp}_cool".to_sym) {
        cool_increase
      }
    end

    def brightness_min
      10.times {
        sleep 15/100.0
        brightness_down
      }
    end

    def all_brightness_min
      all_on
      brightness_min
    end
  end

end
