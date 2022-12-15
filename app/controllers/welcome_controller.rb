class WelcomeController < ApplicationController
  include FilterHelper
  include ParamsConverter

  def index
    requests_service = RequestsService.new(request.user_agent)
    @banner = requests_service.home_banner
    @home_banners = requests_service.home_banners
    operation_type = params[:IDoperaciones] || 1
    @operation_type_param = operation_types.find { |obj| obj[:id] == operation_type.to_s }
    @properties = requests_service.highlighted_properties(operation_type)

    if SITE_CONFIG['display_links_box']
      links = requests_service.landing_links
      if links.present?
        @link_params = {
          title: 'Búsquedas destacadas',
          sections: [
            { title: 'ALQUILER', links: links['Alquileres'] },
            { title: 'VENTA', links: links['Ventas'] },
            { title: 'ALOJAMIENTOS', links: links['Alojamientos'] }
          ]
        }

        @link_params[:sections].try(:each) do |section|
          section[:links].try(:each) do |link|
            params = link['paramsBusqueda']
            link['href'] = params_to_url(params)
          end
        end
      end
    end
  end

  def newsletter_subscribe
    requests_service = RequestsService.new(request.user_agent)
    @result_message = requests_service.newsletter_subscribe(params[:email])
    render partial: 'shared/form_result'
  end

  def about
    if SITE_CONFIG['display_about_page']
      render 'welcome/about_style_' + SITE_CONFIG['about_page_style']
    else
      redirect_to root_url
    end
  end

  def brokers
    if SITE_CONFIG['display_brokers_page']
      render 'welcome/brokers_style_' + SITE_CONFIG['brokers_page_style']
    else
      redirect_to root_url
    end
  end

end
