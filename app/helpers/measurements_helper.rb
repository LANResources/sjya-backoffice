module MeasurementsHelper
  def measurement_popover_link(measurement)
    if measurement.link
      link_to measurement.link, target: '_blank', title: measurement.link, class: 'btn btn-xs btn-primary' do
        content_tag :i, nil, class: 'fa fa-external-link'
      end.html_safe
    end
  end

  def measurement_popover_document_link(measurement)
    if doc = measurement.document
      link_to download_document_path(doc), title: doc.name, class: 'btn btn-xs btn-info' do
        content_tag :i, nil, class: 'fa fa-file-text'
      end.html_safe
    end
  end
end
