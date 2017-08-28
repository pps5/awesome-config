local wibox = require("wibox")
local awful = require("awful")
local vicious = require("vicious")

mem_bar = wibox.widget {
   {
      max_value = 100,
      background_color = "#494B4F",
      color = "#AECF96",
      widget = wibox.widget.progressbar,
   },
   forced_width = 15,
   direction = "east",
   layout = wibox.container.rotate,
}

mem_tip = awful.tooltip({ objects = { mem_bar }})
vicious.cache(vicious.widgets.mem)
vicious.register(mem_bar, vicious.widgets.mem,
                 function(widget, args)
                    usage = string.format("%.2fGB / %.2fGB",
                                          args[2] / 1000,
                                          args[3]/ 1000)
                    mem_tip.text = " RAM: " .. usage
                    mem_bar.widget.value = args[1]
                 end, 2)

memory_widget = wibox.widget {
   mem_bar,
   {
      markup = '<span size="small">RAM</span>',
      align = "center",
      valign = "top",
      widget = wibox.widget.textbox,
   },
   widget = wibox.layout.stack
}
