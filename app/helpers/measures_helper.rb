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
      link_to download_document_path(doc), title: doc.name, target: :_blank do
        content_tag :i, nil, class: 'fa fa-file-text'
      end.html_safe
    end
  end

  def cached_measure_permissions
    @measure_permissions ||= begin
      measure_policy = policy(Measure)
      measurement_policy = policy(Measurement)
      {
        update_measure: measure_policy.update?,
        create_measurement: measurement_policy.create?,
        edit_measurement: measurement_policy.edit?,
        update_measurement: measurement_policy.update?,
        destroy_measurement: measurement_policy.destroy?
      }
    end
  end
end
