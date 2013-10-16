module ApplicationHelper
  def title(page_title, show_title = true)
    content_for(:page_header) do
      content_tag :div, class: 'row-fluid' do
        content_tag :div, class: 'span12' do
          content_tag :h1, page_title.to_s
        end
      end
    end
    content_for(:title){ page_title.to_s }
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
end
