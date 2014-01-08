module DocumentsHelper
  def file_type_label(filename = '')
    ext = filename.split('.').last
    _file_type_label *case ext
                      when /pdf/i
                        ['info', 'PDF']
                      when /jpe?g/i
                        ['warning', 'JPG']
                      when /png/i
                        ['warning', 'PNG']
                      when /gif/i
                        ['warning', 'GIF']
                      when /docx?/i
                        ['info', 'DOC']
                      when /pptx?/i
                        ['info', 'PPT']
                      when /xlsx?/i
                        ['info', 'XLS']
                      else
                        ['default', ext.upcase]
                      end
  end

  def render_tags(tag_list, current_scope = {})
    tag_list.map do |tag|
      tags = current_scope.has_key?(:tag) ? current_scope[:tag] : []
      link_to tag, current_scope.merge({tag: tags | [tag]}), class: 'btn btn-xs btn-default'
    end.join("&nbsp;").html_safe
  end

  private

  def _file_type_label(color, text)
    content_tag :span, text, class: "label label-#{color}"
  end
end
