module IndexAsTableExtensions
  def editable_text_column(resource, attr)
    %{<span data-field="#{resource.class.model_name.singular}[#{attr}]" class="editable">#{resource.send(attr)}</span>}.html_safe
  end
end

class ActiveAdmin::Views::IndexAsTable
  prepend IndexAsTableExtensions
end

module IndexTableForExtensions
  def build_table_body
    tbody = super

    @collection.each_with_index do |item, i|
      tbody.children[i].attributes['data-update-url'] = send("admin_#{item.class.model_name.singular}_path", item)
    end

    tbody
  end
end

class ActiveAdmin::Views::IndexAsTable::IndexTableFor
  prepend IndexTableForExtensions
end

