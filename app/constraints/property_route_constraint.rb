class PropertyRouteConstraint
  def self.matches?(request)
    ['venta', 'alquiler','proyectos','terrenos','propiedades'].include?(request.path_parameters[:operation_type_name])
  end
end
