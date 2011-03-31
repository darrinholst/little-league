module ApplicationHelper
  def javascripts
    list = [
      "jquery-1.5.1.min.js",
      "jquery.dataTables.min.js",
      "jquery.dataTables.sorting.js",
      "rails.js",
      "application.js",
      "inline-edit.js",
      @page_javascript
    ].flatten.compact

    javascript_include_tag(list)
  end

  def editable(field, value)
    content_tag(:span, value, "data-field" => field, :class => "editable")
  end

  def menu(*links)
    unless request.path_info =~ /\/users\//
      content_tag(:ul, :id => "menu", :class => "blue") do
        links.collect{|link| menu_link(link)}.join("\n").html_safe
      end
    end
  end

  def menu_link(link)
    name = link.match(/>(.*)</)[1]
    classes = active_menu?(name) ? "active" : ""
    content_tag(:li, link, :class => classes).html_safe
  end

  def active_menu?(name)
    (name =~ /home/i && request.path_info.eql?("/")) ||
    request.path_info =~ Regexp.new(name, Regexp::IGNORECASE)
  end
end
