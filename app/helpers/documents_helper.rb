module DocumentsHelper
  def file_type_label(type)
    _file_type_label *case type
                      when /pdf/i
                        ['info', 'PDF']
                      when /jpe?g/i
                        ['warning', 'JPG']
                      else
                        ['default', type.split('/').last.to_s.upcase]
                      end
  end

  def render_tags(tag_list)
    tag_list.map do |tag|
      link_to tag, {tag: tag}, class: 'btn btn-xs btn-default'
    end.join("&nbsp;").html_safe
  end

  private

  def _file_type_label(color, text)
    content_tag :span, text, class: "label label-#{color}"
  end
end
