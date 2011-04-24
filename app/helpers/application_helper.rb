module ApplicationHelper
  def stylesheets
    [
      stylesheet_link_tag("application"),
      stylesheet_link_tag("jquery-ui-1.8.11.custom.css"),
      stylesheet_link_tag("fullcalendar.css"),
      stylesheet_link_tag("print",  :media => "print")
    ].join("\n").html_safe
  end

  def header
    render(:partial => 'common/header')
  end

  def editable(field, value)
    content_tag(:span, value, "data-field" => field, :class => "editable")
  end

  def menu(*links)
    unless request.path_info =~ /\/users\//
      content_tag(:ul, :id => "menu") do
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

  def errors_for(model)
    if model.errors.any?
      content_tag(:div, :id => "error_explanation") do
        content = content_tag(:h2, "Unable to save #{model.class.name.downcase}")

        content << content_tag(:ul) do
          model.errors.full_messages.collect{|message| content_tag(:li, message)}.join("\n").html_safe
        end

        content
      end
    end
  end
end
