module ParamsConverter
  include FilterHelper

  def params_to_url(params)
    if params['IDoperaciones'].present?
      operation_type = name_to_param(filter_name('operation_type_id', params['IDoperaciones'].to_s))
    end

    property_type = ''
    if params['IDtipos'].present?
      property_types = Array(params['IDtipos'])
      property_types.each do |value|
        property_type += name_to_param(filter_name('property_type_id', value.to_s)) + ','
      end

      property_type = property_type.chop
    end

    state = name_to_param(filter_name('state_id', params['IDdepartamentos'].to_s)) if params['IDdepartamentos'].present?
    zone = ''
    if params['zonaBarrio'].present?
      zones = Array(params['zonaBarrio'])
      zones.each do |value|
        zone += name_to_param(filter_name('zone_id', value.to_s)) + ','
      end
      zone = zone.chop
    end

    link = "#{operation_type}"
    link += "/#{property_type}" if property_type.present?
    link += "/#{state}" if state.present?
    link += "/#{zone}" if zone.present?

    link
  end
end
