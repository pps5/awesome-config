local wibox = require("wibox")
local awful = require("awful")
local vicious = require("vicious")
vicious.contrib = require("vicious.contrib")

cpu_status_widget = wibox.widget { widget = wibox.layout.fixed.vertical }

-- temperature
temp_widget = wibox.widget { widget = wibox.widget.textbox }
vicious.cache(vicious.widgets.thermal)
vicious.register(temp_widget, vicious.widgets.thermal,
                 '<span size="small">  TEMP:      $1 ℃ </span> ', 2, "thermal_zone0")
temp_unit = wibox.widget { widget = wibox.widget.textbox,
                           markup = '<span size="small"> ℃</span}' }
temp_layout = wibox.widget {
   temp_widget, temp_unit,
   widget = wibox.layout.fixed.horizontal }

-- fan speed
fanlayout = wibox.widget { widget = wibox.layout.fixed.horizontal }
fantitle = wibox.widget { widget = wibox.widget.textbox,
                          markup = '<span size="small">  FAN: </span>' }
fanrpm = wibox.widget { widget = wibox.widget.textbox,
                        forced_width = 40, align = 'right' }
vicious.cache(vicious.contrib.sensors)
vicious.register(fanrpm, vicious.contrib.sensors,
                 '<span size="small">$1 </span>', 2, "fan1")
fanunit = wibox.widget { widget = wibox.widget.textbox,
                         markup = '<span size="small">rpm  </span>' }

fanlayout:add(fantitle, fanrpm, fanunit)
cpu_status_widget:add(temp_layout, fanlayout)
