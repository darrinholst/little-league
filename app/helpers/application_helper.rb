module ApplicationHelper
  def editable(field, value)
    content_tag(:span, value, "data-field" => field, :class => "editable")
  end

  def editable_select(field, value, selection_endpoint)
    content_tag(:span, value, "data-field" => field, "data-endpoint" => selection_endpoint, :class => "editable-select")
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

  def format_birthdate(date)
    date.nil? ? "" : date.strftime("%m/%d/%Y")
  end
end
