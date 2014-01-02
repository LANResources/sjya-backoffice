module MeasuresHelper
  def measure_link(measure)
    if measure.link 
      link_to measure.link, target: '_blank' do
        content_tag :i, nil, class: 'fa fa-external-link'
      end.html_safe
    end
  end

  def measure_document_link(measure)
    if doc = measure.document
      link_to document_download_path(doc) do
        content_tag :i, nil, class: 'fa fa-file-text'
      end.html_safe
    end
  end
end
