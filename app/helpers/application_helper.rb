module ApplicationHelper
  def title(page_title, show_title = true, subtitle = nil)
    content_for(:page_header) do
      content_tag :div, class: 'row' do
        content_tag :div, class: 'col-md-12' do
          content_tag :h1 do
            [page_title.to_s, (subtitle ? content_tag(:small, subtitle).html_safe : nil)].compact.join("&nbsp;").html_safe
          end
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
              link_to crumb[0], crumb[1]
            end
          else
            crumb_items << content_tag(:li, Array(crumb).first, class: 'active')
          end
        end
        crumb_items.join('').html_safe
      end
    end
  end

  def checkbox_images(changeable = true)
    [
      content_tag(:span,
        content_tag(:i, '', class: 'fa fa-thumbs-down'),
        title: (changeable ? 'Click to enable' : 'Disabled'),
        class: 'btn btn-sm btn-danger'),
      content_tag(:span,
        content_tag(:i, '', class: 'fa fa-thumbs-up'),
        title: (changeable ? 'Click to disable' : 'Enabled'),
        class: 'btn btn-sm btn-success')
    ]
  end

  def sortable(column, title = nil, default_direction = 'asc')
    title ||= column.titleize
    icons = { "asc" => "up", "desc" => "down" }
    icon = column == sort_column ? content_tag(:i, "", class: "fa fa-caret-#{icons[sort_direction(default_direction)]}") : ''
    direction = column == sort_column && sort_direction(default_direction) == "asc" ? "desc" : "asc"
    link = link_to title, params.merge(sort: column, direction: direction, page: nil).reject { |k,v| k == "_" }
    [link, icon].join(' ').html_safe
  end

  def render_flash(name, msg)
    color_class = name.to_s == 'error' ? 'danger' : name
    content_tag :div, msg, class: "alert alert-#{color_class}"
  end

  def p_space(content)
    "&nbsp;#{content}".html_safe
  end

  def a_space(content)
    "#{content}&nbsp;".html_safe
  end

  def scope_links(scopes, scope_params)
    links = []
    scopes.each do |scope, vals|
      Array(vals).each_with_index do |val, i|
        path_params = if vals.is_a?(Array) && vals != [val]
                        scope_params.merge({scope => scope_params[scope] - [scope_params[scope][i]]})
                      else
                        scope_params.reject{|k,| k == scope }
                      end

        links << [val, path_params]
      end
    end
    links
  end

  def display_answer_content ans
    if ans.question.id == 5
      Sector.find(ans.answer_text.to_i).name
    else
      ans.answer_text.to_i
    end
  end

  def display_in_percent(val, p)
   val.nonzero? ? "#{(val * 100) / p} %" : "0%".html_safe
  end

end
