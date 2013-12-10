module ApplicationHelper
  def title(page_title, show_title = true)
    content_for(:page_header) do
      content_tag :div, class: 'row' do
        content_tag :div, class: 'col-md-12' do
          content_tag :h1, page_title.to_s
        end
      end
    end
    content_for(:title){ page_title.to_s.html_safe }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def breadcrumbs(*crumbs)
    content_for :breadcrumbs do
      content_tag :ul, class: 'breadcrumb' do
        crumb_items = []
        crumbs.each do |crumb|
          if Array(crumb).length == 2
            crumb_items << content_tag(:li) do
              link_to(crumb[0], crumb[1]) + content_tag(:span, ' /', class: 'divider')
            end
          else
            crumb_items << content_tag(:li, Array(crumb).first, class: 'active')
          end
        end
        crumb_items.join('').html_safe
      end
    end
  end

  def sortable(column, title=nil)
    title ||= column.titleize
    icons = { "asc" => "up", "desc" => "down" }
    icon = column == sort_column ? content_tag(:i, "", class: "fa.fa-caret-#{icons[sort_direction]}") : ''
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link = link_to title, params.merge(sort: column, direction: direction, page: nil).reject { |k,v| k == "_" }
    [link, icon].join(' ').html_safe
  end

  def render_flash(name, msg)
    color_class = name == 'error' ? 'danger' : name
    content_tag :div, msg, class: "alert alert-#{color_class}"
  end
end
