limitless-led
=============

A Ruby client library for controlling the [LimitlessLED v3.0 RGBW color-changing light bulbs] and [LimitlessLED v3.0 White light bulbs] (http://www.limitlessled.com/),
based on the official [LimitlessLED API documentation](http://www.limitlessled.com/dev/).

## Usage

    # White type
    light = LimitlessLed::White.new(host: '192.168.1.100', port: 8899)
    light.group_1_on   # group1 light is on
    light.group_2_warm # group2 light is warm white
    light.group_1_cool # group1 light is cool white or daylight

    light.group_1_brightness_up
    light.group_1_brightness_down
    light.group_1_brightness_max
    light.group_1_brightness_min

    light.all_on # all lights are on

    # Color type
    light = LimitlessLed::RGBW.new(host: '192.168.1.100', port: 8899)

    light.all_on        # all lights are on
    light.all_off       # all lights are off
    light.white         # all lights are white
    light.disco         # disco mode!
    light.disco_faster  # disco mode faster
    light.disco_slower  # disco mode slower

    # change the color by calling #color with either a color string, integer, or Color::RGB object
    # see: https://github.com/halostatue/color/blob/master/lib/color/rgb-colors.rb for a list
    # of all the named colors
    light.color 'Red'                # color is red
    light.color Color::RGB::Red      # color is red
    light.color 170                  # color is red

    # adjust brightness on a scale from 2 - 27 (27 is full brightness)
    bridge.brightness 27              # full brightness

    # control a single group
    group = bridge.group(1)           # supports up to 4 groups (1 - 4)
    group.color 'Blue'
    group.brightness 25


## Note

We are *not affiliated in any way* with the manufacturers of Limitless LED. We just think they are cool.

## Open Source by Hired

[Hired](https://hired.com/?utm_source=opensource&utm_medium=limitless-led&utm_campaign=readme) is a marketplace for top engineering talent to find full-time technology jobs. Talented Ruby developers (like yourself) are in extremely high demand! On Hired, apply once and receive 5 to 15 competing job offers in one week from 800+ technology companies. Average Ruby engineer salaries on Hired are around $120,000 per year!

<a href="https://hired.com/?utm_source=opensource&utm_medium=limitless-led&utm_campaign=readme-banner" target="_blank">
<img src="https://dmrxx81gnj0ct.cloudfront.net/public/hired-banner-light-1-728x90.png" alt="Hired" width="728" height="90" align="center"/>
</a>

We are Ruby developers ourselves, and we use all of our open source projects in production. We always encourge forks, pull requests, and issues. Get in touch with the Hired Engineering team at _opensource@hired.com_.


## License

The MIT License (MIT)

Copyright (c) 2013 Hired, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
