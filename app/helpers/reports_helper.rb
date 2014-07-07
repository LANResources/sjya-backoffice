module ReportsHelper
  def formatted_date_range(report)
    start_date = report.start_date || report.min_date
    end_date = report.end_date || report.max_date

    [start_date, end_date].map{|d| d.strftime('%m/%d/%Y') }.join(' - ')
  end

  def date_range_picker(report)
    text_field_tag nil, formatted_date_range(report), id: 'daterange', class: 'form-control text-center', data: {mindate: report.min_date.strftime('%m/%d/%Y'), maxdate: report.max_date.strftime('%m/%d/%Y')}
  end

  def coalition_meeting_involvement_score_icon(score)
    case score
    when 'High' then 'fa fa-star darkGreen'
    when 'Medium' then 'fa fa-star-half-full yellow'
    when 'Low' then 'fa fa-star-o red'
    end
  end

  def success_rate_category_icon(category)
    icon = case category
            when /very/i then 'fa fa-star'
            when /moderately/i then 'fa fa-star-half-full'
            when /not/i then 'fa fa-star-o'
            else nil
            end

    if icon
      content_tag :i, nil, class: icon, data: {toggle: 'tooltip', placement: 'left', title: category.to_s.titleize}
    else
      category.to_s.titleize
    end
  end

  def number_with_percentage(count, total)
    if count == 0
      '0'
    else
      [count, content_tag(:small, "(#{number_to_percentage (count / total.to_f) * 100, precision: 0})")].join(' ').html_safe
    end
  end

  def short_strategy(strategy)
    /<strong>([\S\s]*?)<\/strong>/i.match(strategy)[1]
  end
end
