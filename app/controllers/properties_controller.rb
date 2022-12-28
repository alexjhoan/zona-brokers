class PropertiesController < ApplicationController
  include ApplicationHelper
  include FilterHelper

  skip_before_action :verify_authenticity_token, only: :consult_express
  before_action :create_requests_service

  def index
    @request_params = {}

    if params[:operation_type_name] == 'proyectos'
      @operation_type_param = {id: '0', name: 'Alquier y Venta'}
      is_proyect = true
    elsif params[:operation_type_name] == 'terrenos'
      @operation_type_param = {id: '0', name: 'Alquier y Venta'}
      params[:property_type_id] = ["3"]
      is_terrain = true
    elsif params[:operation_type_name] == 'propiedades'
      @operation_type_param = {id: '0', name: 'Alquier y Venta'}
    else
      @request_params[:dont_group] = true unless SITE_CONFIG['group_properties']
      @operation_type_param = filters_for_param('operation_type_name', params[:operation_type_name])
    end

    property_types_param = filters_for_param('property_type_name', params[:property_type_name]) if params[:property_type_name]
    states_param = filters_for_param('state_name', params[:state_name])
    zones_param = filters_for_param('zone_name', params[:zone_name]) if params[:zone_name]

    @params = property_params.to_h
    @params.delete(:page)
    @params[:property_type_id] = property_types_param.present? ? property_types_param.map { |value| value[:id] } : params[:property_type_id]
    @params[:state_id] = states_param.present? ? states_param[:id] : params[:state_id]
    @params[:zone_id] = zones_param.present? ? zones_param.map { |value| value[:id] } : params[:zone_id]
    @params.delete(:zone_id) if @params[:state_id].blank?

    # Remove zones that start with D because they represent states
    @params[:zone_id] = @params[:zone_id].reject { |zone| zone =~ /D/ } if @params[:zone_id].present?
    @request_params[:IDoperaciones] = @operation_type_param.present? ? @operation_type_param[:id] : 1
    @request_params[:tipoPropiedad] = @params[:property_type_id] if @params[:property_type_id].present?
    @request_params[:IDdepartamentos] = @params[:state_id] if @params[:state_id].present?
    @request_params[:zonaBarrio] = @params[:zone_id] if @params[:zone_id].present?
    @request_params[:IDdormitorios] = @params[:rooms_id] if @params[:rooms_id].present?
    @request_params[:IDbanios] = @params[:bathrooms_id] if @params[:bathrooms_id].present?
    @request_params[:IDestados] = @params[:status_id] if @params[:status_id].present?
    @request_params[:IDvendedor] = @params[:broker_id] if @params[:broker_id].present?
    @request_params[:IDdisposicion] = @params[:disposition_id] if @params[:disposition_id].present?
    @request_params[:grupoComodidades] = @params[:comodities_id] if @params[:comodities_id].present?
    @request_params[:IDmoneda] = @params[:currency_id] if @params[:currency_id].present?
    @request_params[:fechaDesde] = @params[:from_date].to_date.strftime('%F') if @params[:from_date].present?
    @request_params[:fechaHasta] = @params[:to_date].to_date.strftime('%F') if @params[:to_date].present?
    @request_params[:precioMinimo] = @params[:min_price].gsub("\.", '') if @params[:min_price].present?
    @request_params[:precioMaximo] = @params[:max_price].gsub("\.", '') if @params[:max_price].present?
    @request_params[:IDdistanciaMar] = @params[:sea_distance_id] if @params[:sea_distance_id].present?
    @request_params[:ordenListado] = @params[:list_order] if @params[:list_order].present?
    @request_params[:IDinmobiliarias] = @params[:real_estate_id] if @params[:real_estate_id].present?
    @request_params[:proyectos] = '1' if is_proyect
    @request_params[:financia] = '1' if is_terrain

    if params[:page]
      @request_params[:pagina] = params[:page]
      @current_page = params[:page].to_i
    else
      @current_page = 1
    end

    listing = @requests_service.properties_listing(@request_params)
    @properties = listing['propiedades']
    @pagination = listing['paginado']
    @pagination['max_page'] = @pagination['total'].to_i / @pagination['rpp'].to_i
    @pagination['max_page'] = @pagination['max_page'] + 1 if ((@pagination['total'] % @pagination['rpp']) != 0)
    @search_info = listing['seo']

    if SITE_CONFIG['display_links_box'] && listing['cajaLinks'].present?
      links = listing['cajaLinks']
      @link_params = {
        title: 'Otras opciones',
        sections: [
          { title: links['left'].delete('title'), links: links['left'].values },
          { title: links['middle'].delete('title'), links: links['middle'].values },
          { title: links['right'].delete('title'), links: links['right'].values }
        ]
      }
      @show_links = links['left'].values.present? || links['middle'].values.present? || links['right'].values.present?
    end

    if @params[:state_id].present?
      state_info = states.select { |state| state[:id] == @params[:state_id] }.first
      state_zones = zones.select { |zone| zone[:state] == state_info[:name] && zone[:name].present? }
      @grouped_zones = state_zones.group_by { |zone| zone[:name].first }
      @grouped_states = {}
    else
      @grouped_zones = {}
      @grouped_states = states.group_by { |state| state[:name].first }
    end

    ubication_params = {}
    ubication_params[:IDdepartamento] = @params[:state_id] if @params[:state_id].present?
    @ubications = @requests_service.ubications(ubication_params)
    @canonical_url = properties_seo_url(@params)
  end

  def show
    if params[:listing_type].present? && params[:listing_type] == '2'
      @property = @requests_service.project(params[:id])
    else
      @property = @requests_service.property(params[:id])
      if SITE_CONFIG['display_links_box'] && @property['cajaLinks'].present?
        @link_params = {
          title: 'Otras opciones',
          sections: [
            { title: @property['cajaLinksL'].delete('title'), links: @property['cajaLinksL'].values },
            { title: @property['cajaLinksM'].delete('title'), links: @property['cajaLinksM'].values },
            { title: @property['cajaLinksR'].delete('title'), links: @property['cajaLinksR'].values }
          ]
        }
      end
    end

    @listing_type = params[:listing_type] || '0'
    @similar_properties = @requests_service.similar_properties(params[:id], @property['IDoperaciones'])
    @property['amenities'] = @property['amenities'].split(/[\r\n]+/) if @property['amenities'].present? && !@property['amenities'].is_a?(Array)
    @params = property_params.to_h
    @params[:operation_type_name] = operation_types.find { |operation| operation[:id] == @property['IDoperaciones'] }[:name].downcase if @property['IDoperaciones'].present?
    @params[:property_type_id] = [@property['IDtipos']]
    @params[:state_id] = @property['IDdepartamentos']
    @params[:zone_id] = [@property['IDzonas']]
    @params.delete(:zone_id) if @params[:state_id].blank?
  end

  def highlighted
    operation_type = params[:IDoperaciones] || 1
    @operation_type_param = operation_types.find { |obj| obj[:id] == operation_type.to_s }
    @properties = @requests_service.highlighted_properties(operation_type)
  end

  def consult
    @consult_message = @requests_service.consult(params[:id], question_params.to_h)
    render partial: 'shared/consult_message'
  end

  def consult_express
    @flash_message = @requests_service.consult_express(params[:id], question_params.to_h)
    render partial: 'shared/flash_message'
  end

  def reference_search
    property_id = @requests_service.reference_search(params[:ref])
    if property_id.present? && property_id != 0
      redirect_to action: "show", format: 'html', id: property_id
    else
      flash[:error] = 'Codigo incorrecto'
      redirect_to root_path
    end
  end

  def images
    @images = @requests_service.property_images(params[:id])
  end

  private

  def property_params
    params.permit(:page, :operation_type_name, :state_id, :status_id, :broker_id, :disposition_id,
      :currency_id, :from_date, :to_date, :min_price, :max_price, :sea_distance_id,
      :list_order, :real_estate_id, property_type_id: [], zone_id: [], bathrooms_id: [],
      rooms_id: [], comodities_id: [])
  end

  def question_params
    params.permit(
      :name,
      :email,
      :phone,
      :question,
      :listing_type,
      :rent,
      :query_name
    )
  end

  def create_requests_service
    @requests_service = RequestsService.new(request.user_agent)
  end
end
