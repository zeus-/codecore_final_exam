module ApplicationHelper
  def flash_messages 
    f = " "
    flash.each do |t,v|
      f += content_tag(:div, v, class: flash_class(t.to_sym))
    end
    content_tag(:div, f.html_safe)
  end
  def flash_class(type)
    case type
      when :notice then "alert altert-info"
      when :success then "alert alert-success"
      when :alert then "alert alert-danger"
    end
  end
end
