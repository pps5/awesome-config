local wibox = require("wibox")
local awful = require("awful")
local vicious = require("vicious")


cpu_usage_widget = wibox.widget { widget = wibox.layout.stack }

separator = wibox.widget {
   { widget = wibox.widget.textbox },
   forced_width = 0.85,
   bg = "#FFFFFF",
   opacity = 0.7,
   widget = wibox.container.background
}

core_layout = wibox.widget { widget = wibox.layout.fixed.horizontal }
cores = {}
for i = 1, 4 do
   cores[i] = wibox.widget {
      {
         max_value = 100,
         background_color = "#494B4F",
         color = "#AECF96",
         widget = wibox.widget.progressbar,
      },
      forced_width = 20,
      direction = "east",
      layout = wibox.container.rotate
   }
   core_layout:add(cores[i])
   core_layout:add(separator)
end

cpu_usage_tip = awful.tooltip({ objects = { cpu_usage_widget } })
vicious.cache(vicious.widgets.cpu)
vicious.register(cpu_usage_widget, vicious.widgets.cpu,
                 function(widget, args)
                    for i = 1, 4 do
                       cores[i].widget.value = args[i + 1]
                    end
                    text = string.format(
                       "core1: %3d%%, core2: %3d%%\ncore3: %3d%%, core4: %3d%%",
                       args[1], args[2], args[3], args[4]
                    )
                    cpu_usage_tip.text = text
                 end, 1)
cpu_usage_label = wibox.widget {
   markup = '<span size="small">cpu</span>',
   align = "center",
   valign = "top",
   widget = wibox.widget.textbox
}
cpu_usage_widget:add(core_layout, cpu_usage_label)
