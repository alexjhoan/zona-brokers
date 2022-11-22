module PaginationHelper
  def results_shown(current_page, rpp, total)
    from = ((current_page - 1) * rpp) + 1
    to = (current_page * rpp) > total.to_i ? total : (current_page * rpp)
    return "#{from} - #{to}"
  end

  def pagination(current_page, max_page, request_params)
    first = content_tag :li do
      link_to 'Primera', url_for(request_params.merge({ page: 1 })), class: 'prev hidden-xs'
    end

    previous_2 = content_tag :li do
      link_to @current_page - 2, url_for(request_params.merge({ page: current_page - 2 }))
    end

    previous_1 = content_tag :li do
      link_to current_page - 1, url_for(request_params.merge({ page: current_page - 1 }))
    end

    previous_ = content_tag :li do
      link_to '<', url_for(request_params.merge({ page: current_page - 1 }))
    end

    current = content_tag :li do
      link_to current_page, url_for(request_params), class: 'active'
    end

    next_ = content_tag :li do
      link_to '>', url_for(request_params.merge({ page: current_page + 1 }))
    end

    next_1 = content_tag :li do
      link_to '>', url_for(request_params.merge({ page: current_page + 1 })), class: 'next'
      link_to current_page + 1, url_for(request_params.merge({ page: current_page + 1 }))
    end

    next_2 = content_tag :li do
      link_to current_page + 2, url_for(request_params.merge({ page: current_page + 2 }))
    end

    last = content_tag :li do
      link_to 'Última', url_for(request_params.merge({ page: max_page })), class: 'next hidden-xs'
    end

    content_tag :div, class: "styled-pagination" do
      content_tag :ul do
        if current_page > 1
          concat(first)
          concat(previous_)
          concat(previous_2) if current_page > 2
          concat(previous_1)
        end
        concat(current)
        concat(next_1) if  max_page - current_page > 0
        concat(next_2) if max_page - current_page > 1
        concat(next_) if max_page - current_page > 0
        if current_page != max_page
          concat(last)
        end
      end
    end
  end
end
