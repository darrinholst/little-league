module TableExtensions
  def editable_text_column(resource, attr, value = nil)
    %{<span data-field="#{resource.class.model_name.singular}[#{attr}]" class="editable">#{value || resource.send(attr)}</span>}.html_safe
  end

  def editable_check_box_column(resource, attr, value = nil)
    value ||= resource.send(attr)
    %{<span data-field="#{resource.class.model_name.singular}[#{attr}]" class="editable checkbox status_tag #{value ? 'yes': 'no'}">#{value ? 'yes' : 'no'}</span>}.html_safe
  end

  def editable_select(resource, attr, endpoint, value = nil)
    %{<span data-endpoint="#{endpoint}" data-field="#{resource.class.model_name.singular}[#{attr}]" class="editable-select">#{value || resource.send(attr)}</span>}.html_safe
  end
end

class ActiveAdmin::Views::IndexAsTable
  prepend TableExtensions
end

class ActiveAdmin::Views::Pages::Show
  prepend TableExtensions
end

module TableForExtensions
  def build_table_body
    tbody = super

    @collection.each_with_index do |item, i|
      tbody.children[i].attributes['data-update-url'] = send("admin_#{item.class.model_name.singular}_path", item)
    end

    tbody
  end
end

class ActiveAdmin::Views::TableFor
  prepend TableForExtensions
end


