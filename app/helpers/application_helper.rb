module ApplicationHelper
  require 'uri'
  def show_flash(name, msg)
    if name == "alert"
      name = "error"
    elsif name == "notice"
      name = "info"
    end

    content_tag :div, :class => "alert-message #{name}", :'data-alert' => 'alert' do
      content_tag(:a, "x", :href => "#", :class => 'close') + content_tag(:p, msg)
    end
  end

  def check_item_active(request_url, controller)
    uri = URI.parse(request_url)
    if uri.path == '/'+ controller
      'active'
    end
  end


  def number_format
    number.str
  end

end
