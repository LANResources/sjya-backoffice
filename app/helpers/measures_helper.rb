module MeasuresHelper
  def measure_link(measure)
    if measure.link
      link_to measure.link, target: '_blank', title: measure.link do
        content_tag :i, nil, class: 'fa fa-external-link'
      end.html_safe
    end
  end

  def measure_document_link(measure)
    if doc = measure.document
      link_to download_document_path(doc), title: doc.name do
        content_tag :i, nil, class: 'fa fa-file-text'
      end.html_safe
    end
  end
end
