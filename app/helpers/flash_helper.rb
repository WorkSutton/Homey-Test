module FlashHelper
  COMMON_FLASH_CLASSES = "flex p-4 mb-4 rounded-lg "
  BUTTON_CLASSES = "ml-auto inline-flex h-8 w-8 rounded-lg focus:ring-4 "

  def build_flash(flash_type, message)
    content_tag(:div,
      (content_tag(:span, flash_icon(flash_type), class: "mt-1.5 ml-2") + 
        content_tag(:span, flash_type.capitalize, class: "sr-only") + 
        content_tag(:div, message, class: "mt-1.5 ml-3 text-sm font-medium text-lg") +
        content_tag(:button, [
          content_tag(:span, "Close", class: "sr-only"),
          content_tag(:span, heroicon("x-mark", options: { class: "h-6 w-6 m-1" }, variant: :outline))
        ].join.html_safe, class: [
          BUTTON_CLASSES,
          "
          text-flash-#{flash_type}-500
          #{button_hover(flash_type)}
          hover:text-black
          hover:ring-white
          hover:ring-offset-slate-900
          hover:ring-offset-4
          "
        ], data: { "dismiss-target": "#flash-#{flash_type}", action: "click->flash-message#close" }, "aria-label": "Close", type: :button)
      ),  class: [COMMON_FLASH_CLASSES,"bg-flash-#{flash_type}-300"], id: "flash-#{flash_type}", role: "alert"
    )
  end

  def flash_icon(flash_type)
    icon_type = case flash_type
    when 'notice' then "exclamation-circle"
    when 'info', 'alert' then "exclamation-triangle"
    when 'success' then "check-circle"
    when 'warn' then "exclamation-triangle"
    when 'error' then "x-circle"
    end
    heroicon(icon_type, options: { class: "h-6 w-6" }, variant: :outline)
  end

  def button_hover(flash_type)
    case flash_type
    when 'notice' then 'hover:bg-flash-notice-600'
    when 'info' then 'hover:bg-flash-info-600'
    when 'alert', 'error' then 'hover:bg-flash-alert-600'
    when 'success' then 'hover:bg-flash-success-600'
    when 'warn' then 'hover:bg-flash-warn-600'
    end
  end
end
