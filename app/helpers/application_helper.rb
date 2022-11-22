module ApplicationHelper
  include FilterHelper

  def properties_seo_url(params)
    link_url = "/#{params[:operation_type_name]}"

    return link_url if params[:property_type_id].blank?
    link_url << "/#{filter_url_param('property_type', params[:property_type_id][0])}"

    return link_url if params[:state_id].blank?
    link_url << "/#{filter_url_param('state', params[:state_id])}"

    return link_url if params[:zone_id].blank?
    link_url << "/#{filter_url_param('zone', params[:zone_id][0])}"
  end

  def property_seo_url(property, listing_type)
    title = name_to_param(property['titulo'])
    id = property['IDproyecto'] || property['id']
    ret = listing_type == 2 ? "/proyectos" : "/propiedades"
    ret << "/#{title}/#{id}/?listing_type=#{listing_type}"
  end

  def breadcrumbs(params)
    content_tag(:div, class: 'breadcrumbs') do
      content = 'Estás en: '
      content << link_to(SITE_CONFIG['site_name'], root_path)
      link_url = "/#{params[:operation_type_name]}"
      content << link_to(" > #{params[:operation_type_name].gsub('-', ' ').humanize}", link_url)

      next content.html_safe if params[:property_type_id].blank? || params[:property_type_id].include?('3')

      link_url << "/#{filter_array_to_url(params, :property_type_id)}"
      content << link_to(" > #{filter_array_to_name(params, :property_type_id)}", link_url)

      next content.html_safe if params[:state_id].blank?
      link_url << "/#{filter_url_param('state', params[:state_id])}"
      content << link_to(" > #{filter_name('state', params[:state_id])}", link_url)

      next content.html_safe if params[:zone_id].blank?
      link_url << "/#{filter_array_to_url(params, :zone_id)}"
      content << link_to(" > #{filter_array_to_name(params, :zone_id)}", link_url)

      content.html_safe
    end
  end

  def filter_array_to_url(params, filter_type)
    filters = params[filter_type].map { |filter| filter_url_param(filter_type.to_s, filter) }
    filters.join(',')
  end

  def filter_array_to_name(params, filter_type)
    filters = params[filter_type].map { |filter| filter_name(filter_type.to_s, filter) }
    filters.to_sentence
  end
end
