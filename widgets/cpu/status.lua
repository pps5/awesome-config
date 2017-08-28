local wibox = require("wibox")
local awful = require("awful")
local vicious = require("vicious")
vicious.contrib = require("vicious.contrib")

-- temperature
temp_widget = wibox.widget { widget = wibox.widget.textbox }
vicious.cache(vicious.widgets.thermal)
vicious.register(temp_widget, vicious.widgets.thermal,
                 '<span size="small">  TEMP:      $1 ℃ </span> ',
                 2,
                 "thermal_zone0")
temp_layout = wibox.widget {
   temp_widget,
   {
      widget = wibox.widget.textbox,
      markup = '<span size="small"> ℃</span}'
   },
   widget = wibox.layout.fixed.horizontal
}

-- fan speed
fanrpm = wibox.widget {
   widget = wibox.widget.textbox,
   forced_width = 40,
   align = 'right'
}
vicious.cache(vicious.contrib.sensors)
vicious.register(fanrpm, vicious.contrib.sensors,
                 '<span size="small">$1 </span>', 2, "fan1")
fan_layout = wibox.widget {
   {
      widget = wibox.widget.textbox,
      markup = '<span size="small">  FAN: </span>'
   },
   fanrpm,
   {
      widget = wibox.widget.textbox,
      markup = '<span size="small">rpm  </span>'
   },
   widget = wibox.layout.fixed.horizontal,
}

cpu_status_widget = wibox.widget {
   temp_layout,
   fan_layout,
   widget = wibox.layout.fixed.vertical,
}
