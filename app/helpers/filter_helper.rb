module FilterHelper
  def filter_name(key, value)
    if key != 'real_estate_id'
      function_name = param_to_function(key)
      return filter_for_value(send(function_name), value)
    end
  end

  def filter_for_value(filters, value)
    filter = filters.select { |v| v[:id] == value }.first
    filter.present? ? filter[:name] : ''
  end

  def filters_for_param(filter_name, param)
    function_name = param_to_function(filter_name)
    if ['property_type_name', 'zone_name'].include? filter_name
      filter = send(function_name).select do |value|
        next if value[:name].blank?
        param.split(',').include?(name_to_param(value[:name]))
      end
    else
      filter = send(function_name).select { |value| name_to_param(value[:name]) == param }.first
    end

    filter
  end

  def param_to_function(key)
    function_name = key.remove('_id')
    function_name = function_name.remove('_name')
    function_name = function_name.pluralize(2)
  end

  def name_to_param(name)
    param = name.underscore.gsub(' ', '-')
    param.gsub!('/', 'y')
    param.gsub!('á', 'a')
    param.gsub!('é', 'e')
    param.gsub!('ì', 'i')
    param.gsub!('ó', 'o')
    param.gsub!('ò', 'o')
    param.gsub!('ù', 'u')
    param.gsub!('ú', 'u')
    param.gsub(/[.,+|#¡!¿?@$%&*()]/, '')
  end

  def filter_name_from_id(type, id)
    filter_method = param_to_function(type)
    filter = send(filter_method).find { |filter|  filter[:id] == id }
    filter[:name]
  end

  def filter_url_param(type, id)
    name_to_param(filter_name_from_id(type, id))
  end

  def operation_types
    [
      { id: '1', name: 'Venta' },
      { id: '2', name: 'Alquiler' },
      { id: '3', name: 'Alquiler y Venta' }
      # { id: '4', name: 'Alquiler temporal' }
    ]
  end

  def search_operation_types
    [
      { id: '1', name: 'Venta' },
      { id: '2', name: 'Alquiler' }
      # { id: '3', name: 'Alquiler y Venta' },
      # { id: '4', name: 'Alquiler temporal' }
    ]
  end

  def property_types
    [
      { id: '1', name: 'Casas' } ,
      { id: '2', name: 'Apartamentos' },
      { id: '3', name: 'Terrenos' },
      { id: '4', name: 'Locales Comerciales' },
      { id: '5', name: 'Oficinas' },
      { id: '6', name: 'Chacras / Campos' },
      { id: '7', name: 'Garage / Cocheras' },
      { id: '8', name: 'Negocio Especial' },
      { id: '9', name: 'Edificios' },
      { id: '10', name: 'Hoteles' },
      { id: '11', name: 'Local Industrial' },
      { id: '12', name: 'Otros' }
    ]
  end

  def states
    [
      { id: '1', name: 'Artigas' },
      { id: '2', name: 'Canelones' },
      { id: '3', name: 'Cerro Largo' },
      { id: '4', name: 'Colonia' },
      { id: '5', name: 'Durazno' },
      { id: '6', name:'Flores' },
      { id: '7', name: 'Florida' },
      { id: '8', name: 'Lavalleja' },
      { id: '9', name: 'Maldonado' },
      { id: '10', name: 'Montevideo' },
      { id: '11', name: 'Paysandú' },
      { id: '12', name: 'Río Negro' },
      { id: '13', name: 'Rivera' },
      { id: '14', name: 'Rocha' },
      { id: '15', name: 'Salto' },
      { id: '16', name: 'San José' },
      { id: '17', name: 'Soriano' },
      { id: '18', name: 'Tacuarembó' },
      { id: '19', name: 'Treinta y Tres' }
    ]
  end

  def zones
    [
     { id: 'D10', state: 'Montevideo' },
     { id: '1', state: 'Montevideo', name: 'Buceo' },
     { id: '2', state: 'Montevideo', name: 'Parque Batlle' },
     { id: '3', state: 'Montevideo', name: 'Parque Rodó' },
     { id: '4', state: 'Montevideo', name: 'Pocitos' },
     { id: '5', state: 'Montevideo', name: 'Pocitos Nuevo' },
     { id: '6', state: 'Montevideo', name: 'Puerto Buceo' },
     { id: '7', state: 'Montevideo', name: 'Punta Carretas' },
     { id: '8', state: 'Montevideo', name: 'Villa Biarritz' },
     { id: '9', state: 'Montevideo', name: 'Villa Dolores' },
     { id: '10', state: 'Montevideo', name: 'Bañados de Carrasco' },
     { id: '11', state: 'Montevideo', name: 'Barra de Carrasco' },
     { id: '12', state: 'Montevideo', name: 'Barrios Privados' },
     { id: '13', state: 'Montevideo', name: 'Carrasco' },
     { id: '14', state: 'Montevideo', name: 'Carrasco Este' },
     { id: '15', state: 'Montevideo', name: 'Carrasco Norte' },
     { id: '16', state: 'Montevideo', name: 'Malvín' },
     { id: '17', state: 'Montevideo', name: 'Parque Miramar' },
     { id: '18', state: 'Montevideo', name: 'Punta Gorda' },
     { id: '19', state: 'Montevideo', name: 'Aguada' },
     { id: '20', state: 'Montevideo', name: 'Barrio Sur' },
     { id: '21', state: 'Montevideo', name: 'Centro' },
     { id: '22', state: 'Montevideo', name: 'Ciudad Vieja' },
     { id: '23', state: 'Montevideo', name: 'Cordón' },
     { id: '24', state: 'Montevideo', name: 'La Comercial' },
     { id: '25', state: 'Montevideo', name: 'Palermo' },
     { id: '26', state: 'Montevideo', name: 'Puerto' },
     { id: '27', state: 'Montevideo', name: 'Tres Cruces' },
     { id: '28', state: 'Montevideo', name: 'Villa Muñoz' },
     { id: '29', state: 'Montevideo', name: 'Aires Puros' },
     { id: '30', state: 'Montevideo', name: 'Arroyo Seco' },
     { id: '31', state: 'Montevideo', name: 'Atahualpa' },
     { id: '32', state: 'Montevideo', name: 'Bella Vista' },
     { id: '33', state: 'Montevideo', name: 'Brazo Oriental' },
     { id: '34', state: 'Montevideo', name: 'Capurro' },
     { id: '35', state: 'Montevideo', name: 'Capurro Bella Vista' },
     { id: '36', state: 'Montevideo', name: 'Cerrito' },
     { id: '37', state: 'Montevideo', name: 'Goes' },
     { id: '38', state: 'Montevideo', name: 'Jacinto Vera' },
     { id: '39', state: 'Montevideo', name: 'Paso Molino' },
     { id: '40', state: 'Montevideo', name: 'Prado' },
     { id: '41', state: 'Montevideo', name: 'Prado Nueva Savona' },
     { id: '42', state: 'Montevideo', name: 'Reducto' },
     { id: '43', state: 'Montevideo', name: 'Perez Castellanos' },
     { id: '44', state: 'Montevideo', name: 'La Figurita' },
     { id: '45', state: 'Montevideo', name: 'Bella Italia' },
     { id: '46', state: 'Montevideo', name: 'Bolivar' },
     { id: '47', state: 'Montevideo', name: 'Flor de Maroñas' },
     { id: '48', state: 'Montevideo', name: 'Ituzaingó' },
     { id: '49', state: 'Montevideo', name: 'Jardines del Hipódromo' },
     { id: '50', state: 'Montevideo', name: 'La Blanqueada' },
     { id: '51', state: 'Montevideo', name: 'Larrañaga' },
     { id: '52', state: 'Montevideo', name: 'Las Canteras' },
     { id: '53', state: 'Montevideo', name: 'Malvín Norte' },
     { id: '54', state: 'Montevideo', name: 'Manga' },
     { id: '55', state: 'Montevideo', name: 'Maroñas' },
     { id: '56', state: 'Montevideo', name: 'Mercado Modelo' },
     { id: '57', state: 'Montevideo', name: 'Piedras Blancas' },
     { id: '58', state: 'Montevideo', name: 'Punta Rieles' },
     { id: '59', state: 'Montevideo', name: 'Unión' },
     { id: '60', state: 'Montevideo', name: 'Villa Española' },
     { id: '61', state: 'Montevideo', name: 'Villa García Manga Rural' },
     { id: '62', state: 'Montevideo', name: 'Casavalle' },
     { id: '63', state: 'Montevideo', name: 'Colón' },
     { id: '64', state: 'Montevideo', name: 'Conciliación' },
     { id: '65', state: 'Montevideo', name: 'Las Acacias' },
     { id: '66', state: 'Montevideo', name: 'Lezica' },
     { id: '67', state: 'Montevideo', name: 'Melilla' },
     { id: '68', state: 'Montevideo', name: 'Peñarol' },
     { id: '69', state: 'Montevideo', name: 'Peñarol Lavalleja' },
     { id: '70', state: 'Montevideo', name: 'Sayago' },
     { id: '71', state: 'Montevideo', name: 'Marconi' },
     { id: '72', state: 'Montevideo', name: 'Belvedere' },
     { id: '73', state: 'Montevideo', name: 'Casabo' },
     { id: '74', state: 'Montevideo', name: 'Casabo Pajas Blancas' },
     { id: '75', state: 'Montevideo', name: 'Cerro' },
     { id: '76', state: 'Montevideo', name: 'La Teja' },
     { id: '77', state: 'Montevideo', name: 'Nuevo París' },
     { id: '78', state: 'Montevideo', name: 'Paso de la Arena' },
     { id: '79', state: 'Montevideo', name: 'Tres Ombues Pblo Victoria' },
     { id: '80', state: 'Montevideo', name: 'La Paloma Tomkinson' },
     { id: '81', state: 'Montevideo', name: 'Pajas Blancas' },
     { id: '2795', state: 'Montevideo', name: 'Camino Maldonado' },
     { id: 'D9', state: 'Maldonado' },
     { id: '108', state: 'Maldonado', name: 'Punta del Este' },
     { id: '83', state: 'Maldonado', name: 'Gregorio Aznares' },
     { id: '85', state: 'Maldonado', name: 'Pan de Azucar' },
     { id: '86', state: 'Maldonado', name: 'Piriápolis' },
     { id: '87', state: 'Maldonado', name: 'Beaulieu' },
     { id: '88', state: 'Maldonado', name: 'Bella Vista' },
     { id: '89', state: 'Maldonado', name: 'Centro' },
     { id: '90', state: 'Maldonado', name: 'Cerro del Toro' },
     { id: '91', state: 'Maldonado', name: 'Cerro San Antonio' },
     { id: '92', state: 'Maldonado', name: 'Fuente Venus' },
     { id: '94', state: 'Maldonado', name: 'Los Ángeles' },
     { id: '95', state: 'Maldonado', name: 'Playa Grande' },
     { id: '102', state: 'Maldonado', name: 'Punta Fría' },
     { id: '104', state: 'Maldonado', name: 'Rinconada' },
     { id: '2229', state: 'Maldonado', name: 'Barrio Country' },
     { id: '2230', state: 'Maldonado', name: 'Barrio la Falda' },
     { id: '2231', state: 'Maldonado', name: 'Beaullieu' },
     { id: '2232', state: 'Maldonado', name: 'Castillo de Piria' },
     { id: '2233', state: 'Maldonado', name: 'La Cascada' },
     { id: '2234', state: 'Maldonado', name: 'La Gloria' },
     { id: '2235', state: 'Maldonado', name: 'Piriapolis Centro Comercial' },
     { id: '2236', state: 'Maldonado', name: 'Zona Hotel Argentino' },
     { id: '101', state: 'Maldonado', name: 'Punta Colorada' },
     { id: '93', state: 'Maldonado', name: 'Las Flores' },
     { id: '96', state: 'Maldonado', name: 'Playa Hermosa' },
     { id: '97', state: 'Maldonado', name: 'Playa Verde' },
     { id: '99', state: 'Maldonado', name: 'Proa del Mar' },
     { id: '103', state: 'Maldonado', name: 'Punta Negra' },
     { id: '105', state: 'Maldonado', name: 'San Francisco' },
     { id: '106', state: 'Maldonado', name: 'Solís' },
     { id: '344', state: 'Maldonado', name: 'Solanas' },
     { id: '107', state: 'Maldonado', name: 'Portezuelo' },
     { id: '119', state: 'Maldonado', name: 'Lagunas del Diario' },
     { id: '129', state: 'Maldonado', name: 'Punta Ballena' },
     { id: '2237', state: 'Maldonado', name: 'Bahia del Pinar' },
     { id: '2238', state: 'Maldonado', name: 'Chihuahua' },
     { id: '2239', state: 'Maldonado', name: 'Club del Lago' },
     { id: '2240', state: 'Maldonado', name: 'El Pejerrey' },
     { id: '2241', state: 'Maldonado', name: 'La Pataia' },
     { id: '2242', state: 'Maldonado', name: 'Laguna del Diario' },
     { id: '2243', state: 'Maldonado', name: 'Laguna del Sauce' },
     { id: '2244', state: 'Maldonado', name: 'Las Cumbres' },
     { id: '2245', state: 'Maldonado', name: 'Ocean Park' },
     { id: '2246', state: 'Maldonado', name: 'Playa las Grutas' },
     { id: '2247', state: 'Maldonado', name: 'Portezuelo Bosque' },
     { id: '2248', state: 'Maldonado', name: 'Punta del Chileno' },
     { id: '2249', state: 'Maldonado', name: 'Rinconada Alta' },
     { id: '2250', state: 'Maldonado', name: 'Santa Hilda' },
     { id: '2251', state: 'Maldonado', name: 'Sauce de Portezuelo' },
     { id: '2252', state: 'Maldonado', name: 'Tio Tom' },
     { id: '109', state: 'Maldonado', name: 'Aidy Grill' },
     { id: '110', state: 'Maldonado', name: 'Arcobaleno' },
     { id: '111', state: 'Maldonado', name: 'Barrio Córdoba' },
     { id: '112', state: 'Maldonado', name: 'Beverly Hills' },
     { id: '113', state: 'Maldonado', name: 'Cantegril' },
     { id: '115', state: 'Maldonado', name: 'Golf' },
     { id: '120', state: 'Maldonado', name: 'Las Delicias' },
     { id: '124', state: 'Maldonado', name: 'Península' },
     { id: '125', state: 'Maldonado', name: 'Pinares' },
     { id: '126', state: 'Maldonado', name: 'Playa Brava' },
     { id: '127', state: 'Maldonado', name: 'Playa Mansa' },
     { id: '128', state: 'Maldonado', name: 'Puerto' },
     { id: '131', state: 'Maldonado', name: 'Punta Shopping' },
     { id: '132', state: 'Maldonado', name: 'Rincón del Indio' },
     { id: '133', state: 'Maldonado', name: 'Roosevelt' },
     { id: '134', state: 'Maldonado', name: 'San Rafael' },
     { id: '2258', state: 'Maldonado', name: 'Playa Mansa Las Delicias' },
     { id: '2259', state: 'Maldonado', name: 'Playa Mansa Pinares' },
     { id: '2260', state: 'Maldonado', name: 'Zona El Golf' },
     { id: '2261', state: 'Maldonado', name: 'Zona Roosevelt' },
     { id: '117', state: 'Maldonado', name: 'La Barra' },
     { id: '118', state: 'Maldonado', name: 'La Pastora' },
     { id: '121', state: 'Maldonado', name: 'Lugano' },
     { id: '122', state: 'Maldonado', name: 'Manantiales' },
     { id: '123', state: 'Maldonado', name: 'Montoya' },
     { id: '130', state: 'Maldonado', name: 'Punta Piedras' },
     { id: '2168', state: 'Maldonado', name: 'Balneario Buenos Aires' },
     { id: '2186', state: 'Maldonado', name: 'Arenas de José Ignacio' },
     { id: '2187', state: 'Maldonado', name: 'Edén Rock' },
     { id: '2188', state: 'Maldonado', name: 'El Caracol Costa Bonita' },
     { id: '2189', state: 'Maldonado', name: 'Estrella de Mar' },
     { id: '2191', state: 'Maldonado', name: 'La Juanita' },
     { id: '2192', state: 'Maldonado', name: 'Laguna de Jose Ignacio' },
     { id: '2193', state: 'Maldonado', name: 'Laguna Garzón' },
     { id: '2194', state: 'Maldonado', name: 'Las Garzas' },
     { id: '2195', state: 'Maldonado', name: 'Pueblo Garzón' },
     { id: '2196', state: 'Maldonado', name: 'San Sebastián' },
     { id: '2197', state: 'Maldonado', name: 'San Vicente' },
     { id: '2198', state: 'Maldonado', name: 'Santa Isabel' },
     { id: '2199', state: 'Maldonado', name: 'Santa Monica' },
     { id: '2200', state: 'Maldonado', name: 'Santa Rita' },
     { id: '301', state: 'Maldonado', name: 'Las Garzas' },
     { id: '657', state: 'Maldonado', name: 'Laguna Garzón' },
     { id: '82', state: 'Maldonado', name: 'Aigua' },
     { id: '84', state: 'Maldonado', name: 'Maldonado' },
     { id: '135', state: 'Maldonado', name: 'San Carlos' },
     { id: 'D2', state: 'Canelones' },
     { id: '136', state: 'Canelones', name: 'Atlántida' },
     { id: '137', state: 'Canelones', name: 'Balneario Argentino' },
     { id: '138', state: 'Canelones', name: 'Barra de Carrasco' },
     { id: '139', state: 'Canelones', name: 'Bello Horizonte' },
     { id: '140', state: 'Canelones', name: 'Canelones' },
     { id: '141', state: 'Canelones', name: 'Ciudad de la Costa' },
     { id: '142', state: 'Canelones', name: 'Colinas de Solymar' },
     { id: '143', state: 'Canelones', name: 'Costa Azul' },
     { id: '144', state: 'Canelones', name: 'Cuchilla Alta' },
     { id: '145', state: 'Canelones', name: 'El Bosque' },
     { id: '146', state: 'Canelones', name: 'El Pinar' },
     { id: '147', state: 'Canelones', name: 'Empalme Olmos' },
     { id: '148', state: 'Canelones', name: 'Fortín de Santa Rosa' },
     { id: '149', state: 'Canelones', name: 'Guazú Virá' },
     { id: '150', state: 'Canelones', name: 'Jaureguiberry' },
     { id: '151', state: 'Canelones', name: 'La Floresta' },
     { id: '152', state: 'Canelones', name: 'La Paz' },
     { id: '153', state: 'Canelones', name: 'La Tuna' },
     { id: '154', state: 'Canelones', name: 'Lagomar' },
     { id: '155', state: 'Canelones', name: 'Las Piedras' },
     { id: '156', state: 'Canelones', name: 'Las Toscas' },
     { id: '157', state: 'Canelones', name: 'Lomas de Solymar' },
     { id: '158', state: 'Canelones', name: 'Los Cerrillos' },
     { id: '159', state: 'Canelones', name: 'Los Titanes' },
     { id: '160', state: 'Canelones', name: 'Marindia' },
     { id: '161', state: 'Canelones', name: 'Médanos de Solymar' },
     { id: '162', state: 'Canelones', name: 'Migues' },
     { id: '163', state: 'Canelones', name: 'Montes de Solymar' },
     { id: '164', state: 'Canelones', name: 'Neptunia' },
     { id: '165', state: 'Canelones', name: 'Pando' },
     { id: '166', state: 'Canelones', name: 'Parque de Solymar' },
     { id: '167', state: 'Canelones', name: 'Parque del Plata' },
     { id: '168', state: 'Canelones', name: 'Pinamar' },
     { id: '169', state: 'Canelones', name: 'Pinares de Solymar' },
     { id: '170', state: 'Canelones', name: 'Progreso' },
     { id: '171', state: 'Canelones', name: 'Salinas' },
     { id: '172', state: 'Canelones', name: 'San Antonio (Uyca)' },
     { id: '173', state: 'Canelones', name: 'San Cristóbal' },
     { id: '174', state: 'Canelones', name: 'San Jacinto' },
     { id: '175', state: 'Canelones', name: 'San Luis' },
     { id: '176', state: 'Canelones', name: 'San Ramón' },
     { id: '177', state: 'Canelones', name: 'Santa Ana' },
     { id: '178', state: 'Canelones', name: 'Santa Lucía' },
     { id: '179', state: 'Canelones', name: 'Santa Lucía del Este' },
     { id: '180', state: 'Canelones', name: 'Santa Rosa' },
     { id: '181', state: 'Canelones', name: 'Sauce' },
     { id: '182', state: 'Canelones', name: 'Shangrilá' },
     { id: '183', state: 'Canelones', name: 'Solymar' },
     { id: '184', state: 'Canelones', name: 'Tala' },
     { id: '185', state: 'Canelones', name: 'Toledo' },
     { id: '186', state: 'Canelones', name: 'Villa Argentina' },
     { id: '187', state: 'Canelones', name: 'Barrios Privados' },
     { id: 'D1', state: 'Artigas' },
     { id: '188', state: 'Artigas', name: 'Artigas' },
     { id: '189', state: 'Artigas', name: 'Baltasar Brum' },
     { id: '190', state: 'Artigas', name: 'Bella Unión' },
     { id: '191', state: 'Artigas', name: 'Bernabé Rivera' },
     { id: '192', state: 'Artigas', name: 'Cuaro' },
     { id: '193', state: 'Artigas', name: 'Javier de Viana' },
     { id: '194', state: 'Artigas', name: 'Pintadito' },
     { id: '195', state: 'Artigas', name: 'Tomás Gomensoro' },
     { id: '196', state: 'Artigas', name: 'Topador' },
     { id: 'D3', state: 'Cerro Largo' },
     { id: '197', state: 'Cerro Largo', name: 'Aceguá' },
     { id: '198', state: 'Cerro Largo', name: 'Cerro de las Cuentas' },
     { id: '199', state: 'Cerro Largo', name: 'Fraile Muerto' },
     { id: '200', state: 'Cerro Largo', name: 'Isidoro Noblía' },
     { id: '201', state: 'Cerro Largo', name: 'Melo' },
     { id: '202', state: 'Cerro Largo', name: 'Río Branco' },
     { id: '203', state: 'Cerro Largo', name: 'Tres Islas' },
     { id: 'D4', state: 'Colonia' },
     { id: '204', state: 'Colonia', name: 'Arrivillaga' },
     { id: '205', state: 'Colonia', name: 'Artilleros' },
     { id: '206', state: 'Colonia', name: 'Barker' },
     { id: '207', state: 'Colonia', name: 'Blanca Arena' },
     { id: '208', state: 'Colonia', name: 'Boca del Rosario' },
     { id: '209', state: 'Colonia', name: 'Brisas del Plata' },
     { id: '210', state: 'Colonia', name: 'Carmelo' },
     { id: '211', state: 'Colonia', name: 'Cerros de San Juan' },
     { id: '212', state: 'Colonia', name: 'Colonia Cosmopolita' },
     { id: '213', state: 'Colonia', name: 'Colonia del Sacramnto' },
     { id: '214', state: 'Colonia', name: 'Colonia Mguelete' },
     { id: '215', state: 'Colonia', name: 'Colonia Valdense' },
     { id: '216', state: 'Colonia', name: 'Conchillas' },
     { id: '217', state: 'Colonia', name: 'Cufré' },
     { id: '218', state: 'Colonia', name: 'El semillero' },
     { id: '219', state: 'Colonia', name: 'El Solado' },
     { id: '220', state: 'Colonia', name: 'Estanzuela' },
     { id: '221', state: 'Colonia', name: 'Juan Lacaze' },
     { id: '222', state: 'Colonia', name: 'La Paz (Uyco)' },
     { id: '223', state: 'Colonia', name: 'Los Pinos' },
     { id: '224', state: 'Colonia', name: 'Nueva Helvecia' },
     { id: '225', state: 'Colonia', name: 'Nueva Palmira' },
     { id: '226', state: 'Colonia', name: 'Ombúes de Lavalle' },
     { id: '227', state: 'Colonia', name: 'Paraje Minuano' },
     { id: '228', state: 'Colonia', name: 'Paso Minuano' },
     { id: '229', state: 'Colonia', name: 'Paso Antolín' },
     { id: '230', state: 'Colonia', name: 'Pastoreo' },
     { id: '231', state: 'Colonia', name: 'Playa Azul' },
     { id: '232', state: 'Colonia', name: 'Playa Britópolis' },
     { id: '233', state: 'Colonia', name: 'Playa Parant' },
     { id: '234', state: 'Colonia', name: 'Puerto Inglés' },
     { id: '235', state: 'Colonia', name: 'Rosario' },
     { id: '236', state: 'Colonia', name: 'Santa Regina' },
     { id: '237', state: 'Colonia', name: 'Tarariras' },
     { id: 'D5', state: 'Durazno' },
     { id: '238', state: 'Durazno', name: 'Durazno' },
     { id: '239', state: 'Durazno', name: 'San Jorge' },
     { id: '240', state: 'Durazno', name: 'Santa Bernardita' },
     { id: 'D6', state:'Flores' },
     { id: '241', state: 'Flores', name: 'San Gregorio Carrio' },
     { id: '242', state: 'Flores', name: 'Trinidad' },
     { id: 'D7', state: 'Florida' },
     { id: '243', state: 'Florida', name: '25  state:de agosto' },
     { id: '244', state: 'Florida', name: 'Cardal' },
     { id: '245', state: 'Florida', name: 'Cerro Colorado (FI)' },
     { id: '246', state: 'Florida', name: 'Florida' },
     { id: '247', state: 'Florida', name: 'Fray Marcos' },
     { id: '248', state: 'Florida', name: 'Independencia' },
     { id: '249', state: 'Florida', name: 'La Cruz' },
     { id: '250', state: 'Florida', name: 'Pintado' },
     { id: '251', state: 'Florida', name: 'Sarandí Grande' },
     { id: 'D8', state: 'Lavalleja' },
     { id: '252', state: 'Lavalleja', name: 'Colón' },
     { id: '253', state: 'Lavalleja', name: 'Illescas' },
     { id: '254', state: 'Lavalleja', name: 'José Pedro Varela' },
     { id: '255', state: 'Lavalleja', name: 'La Mariscala' },
     { id: '256', state: 'Lavalleja', name: 'María Albina' },
     { id: '257', state: 'Lavalleja', name: 'Minas' },
     { id: '258', state: 'Lavalleja', name: 'Piraraja' },
     { id: '259', state: 'Lavalleja', name: 'Solís de Mataojo' },
     { id: '260', state: 'Lavalleja', name: 'Zapican' },
     { id: 'D11', state: 'Paysandú' },
     { id: '261', state: 'Paysandú', name: 'Chapicuy' },
     { id: '262', state: 'Paysandú', name: 'Guaviyú' },
     { id: '263', state: 'Paysandú', name: 'Paysandú' },
     { id: '264', state: 'Paysandú', name: 'Piedra Sola' },
     { id: '265', state: 'Paysandú', name: 'Quebracho' },
     { id: 'D12', state: 'Río Negro' },
     { id: '266', state: 'Río Negro', name: 'Algorta' },
     { id: '267', state: 'Río Negro', name: 'Andresito' },
     { id: '268', state: 'Río Negro', name: 'Barrio Anglo' },
     { id: '269', state: 'Río Negro', name: 'Cardozo' },
     { id: '270', state: 'Río Negro', name: 'Carlos Reyles' },
     { id: '271', state: 'Río Negro', name: 'Fray Bentos' },
     { id: '272', state: 'Río Negro', name: 'General Borges' },
     { id: '273', state: 'Río Negro', name: 'Grecco' },
     { id: '274', state: 'Río Negro', name: 'Las Cañas' },
     { id: '275', state: 'Río Negro', name: 'Nuevo Berlín' },
     { id: '276', state: 'Río Negro', name: 'Pueblo Orgoroso' },
     { id: '277', state: 'Río Negro', name: 'Rincón del Bonete' },
     { id: '278', state: 'Río Negro', name: 'San Javier' },
     { id: '279', state: 'Río Negro', name: 'Villa María' },
     { id: '280', state: 'Río Negro', name: 'Young' },
     { id: 'D13', state: 'Rivera' },
     { id: '281', state: 'Rivera', name: 'La Pedrera (Rv)' },
     { id: '282', state: 'Rivera', name: 'Laguñón' },
     { id: '283', state: 'Rivera', name: 'Mandubí' },
     { id: '284', state: 'Rivera', name: 'Masoller' },
     { id: '285', state: 'Rivera', name: 'Minas de Corrales' },
     { id: '286', state: 'Rivera', name: 'Paso Campamento' },
     { id: '287', state: 'Rivera', name: 'Rivera' },
     { id: '288', state: 'Rivera', name: 'Santa Teresa' },
     { id: '289', state: 'Rivera', name: 'Traqueras' },
     { id: 'D14', state: 'Rocha' },
     { id: '2253', state: 'Rocha', name: 'Centro' },
     { id: '2254', state: 'Rocha', name: 'Playa de la Viuda' },
     { id: '2255', state: 'Rocha', name: 'Playa del Rivero' },
     { id: '2256', state: 'Rocha', name: 'Zona el Bosque' },
     { id: '2257', state: 'Rocha', name: 'Zona Terminal' },
     { id: '302', state: 'Rocha', name: 'Punta del Diablo' },
     { id: '649', state: 'Rocha', name: 'Punta Rubia' },
     { id: '2217', state: 'Rocha', name: 'Santa Isabel de la Pedrera' },
     { id: '2218', state: 'Rocha', name: 'Barracas de la Pedrera' },
     { id: '2219', state: 'Rocha', name: 'Centro' },
     { id: '2220', state: 'Rocha', name: 'Diamantes de la Pedrera' },
     { id: '2221', state: 'Rocha', name: 'Playa del Barco' },
     { id: '2222', state: 'Rocha', name: 'Playa Desplayado' },
     { id: '2223', state: 'Rocha', name: 'Pueblo Nuevo' },
     { id: '2224', state: 'Rocha', name: 'San Antonio' },
     { id: '2225', state: 'Rocha', name: 'San Sebastián de la Pedrera' },
     { id: '2226', state: 'Rocha', name: 'Tajamares de la Pedrera' },
     { id: '651', state: 'Rocha', name: 'Santa María De Rocha' },
     { id: '2203', state: 'Rocha', name: 'Barrio Country' },
     { id: '2204', state: 'Rocha', name: 'Barrio Parque' },
     { id: '2205', state: 'Rocha', name: 'Casco Viejo' },
     { id: '2206', state: 'Rocha', name: 'Centro' },
     { id: '2207', state: 'Rocha', name: 'El Cabito' },
     { id: '2208', state: 'Rocha', name: 'Laguna de Rocha' },
     { id: '2209', state: 'Rocha', name: 'Los Botes' },
     { id: '2210', state: 'Rocha', name: 'Playa Anaconda' },
     { id: '2211', state: 'Rocha', name: 'Playa Bahía' },
     { id: '2212', state: 'Rocha', name: 'Playa la Balconada' },
     { id: '2213', state: 'Rocha', name: 'Playa Serena y Solari' },
     { id: '2214', state: 'Rocha', name: 'Rincón del Rosario' },
     { id: '2215', state: 'Rocha', name: 'Santa María de Rocha' },
     { id: '2216', state: 'Rocha', name: 'La Riviera' },
     { id: '644', state: 'Rocha', name: 'Antoniópolis' },
     { id: '645', state: 'Rocha', name: 'Arachania' },
     { id: '646', state: 'Rocha', name: 'Costa Azul' },
     { id: '647', state: 'Rocha', name: 'La Aguada' },
     { id: '648', state: 'Rocha', name: 'Oceanía Del Polonio' },
     { id: '2181', state: 'Rocha', name: 'Cabo' },
     { id: '2183', state: 'Rocha', name: 'Playa la Calavera (Norte)' },
     { id: '2184', state: 'Rocha', name: 'Playa Sur' },
     { id: '2179', state: 'Rocha', name: 'Balneario la Alborada' },
     { id: '2180', state: 'Rocha', name: 'Barra do Chui Brasil' },
     { id: '2175', state: 'Rocha', name: 'Balneario Puimayen' },
     { id: '2176', state: 'Rocha', name: 'Barra del Chuy' },
     { id: '295', state: 'Rocha', name: 'Chuy' },
     { id: '290', state: 'Rocha', name: 'Aguas Dulces' },
     { id: '291', state: 'Rocha', name: 'Barra de Valizas' },
     { id: '650', state: 'Rocha', name: 'Valizas' },
     { id: '294', state: 'Rocha', name: 'Castillos' },
     { id: '296', state: 'Rocha', name: 'Dieciocho de Julio (Ro)' },
     { id: '303', state: 'Rocha', name: 'Rocha' },
     { id: '656', state: 'Rocha', name: 'Lascano' },
     { id: '297', state: 'Rocha', name: 'El Palmar' },
     { id: '653', state: 'Rocha', name: 'La Esmeralda' },
     { id: '655', state: 'Rocha', name: 'La Coronilla' },
     { id: 'D15', state: 'Salto' },
     { id: '304', state: 'Salto', name: 'Arenitas Blancas' },
     { id: '305', state: 'Salto', name: 'Artaux' },
     { id: '306', state: 'Salto', name: 'Belén' },
     { id: '307', state: 'Salto', name: 'Colonia 18  state:de Julio' },
     { id: '308', state: 'Salto', name: 'Constitución' },
     { id: '309', state: 'Salto', name: 'Salto' },
     { id: '310', state: 'Salto', name: 'Termas del Arapey' },
     { id: '311', state: 'Salto', name: 'Termas del Daymán' },
     { id: 'D16', state: 'San José' },
     { id: '312', state: 'San José', name: 'Boca del Cufré' },
     { id: '313', state: 'San José', name: 'Delta del Tigre' },
     { id: '314', state: 'San José', name: 'Ecilda Paullier' },
     { id: '315', state: 'San José', name: 'Ituzaingó' },
     { id: '316', state: 'San José', name: 'Libertad' },
     { id: '317', state: 'San José', name: 'Playa Pascual' },
     { id: '318', state: 'San José', name: 'San José' },
     { id: '319', state: 'San José', name: 'San José de Mayo' },
     { id: '320', state: 'San José', name: 'Scavino' },
     { id: '321', state: 'San José', name: 'Villa Rodríguez' },
     { id: 'D17', state: 'Soriano' },
     { id: '322', state: 'Soriano', name: 'Canada Nieto' },
     { id: '323', state: 'Soriano', name: 'Cardona' },
     { id: '324', state: 'Soriano', name: 'Dolores' },
     { id: '325', state: 'Soriano', name: 'Egana' },
     { id: '326', state: 'Soriano', name: 'Florencio Sánchez' },
     { id: '327', state: 'Soriano', name: 'José Enrique Rodó' },
     { id: '328', state: 'Soriano', name: 'Mercedes' },
     { id: '329', state: 'Soriano', name: 'Palmitas' },
     { id: '330', state: 'Soriano', name: 'Risso' },
     { id: '331', state: 'Soriano', name: 'Santa Catalina' },
     { id: 'D18', state: 'Tacuarembó' },
     { id: '332', state: 'Tacuarembó', name: 'Clara' },
     { id: '333', state: 'Tacuarembó', name: 'Paso Bonilla' },
     { id: '334', state: 'Tacuarembó', name: 'Paso de los Toros' },
     { id: '335', state: 'Tacuarembó', name: 'Paso del Cerro' },
     { id: '336', state: 'Tacuarembó', name: 'San Gregorio de Polanco' },
     { id: '337', state: 'Tacuarembó', name: 'Tacuarembó' },
     { id: '338', state: 'Tacuarembó', name: 'Villa Ansina' },
     { id: 'D19', state: 'Treinta y Tres' },
     { id: '339', state: 'Treinta y Tres', name: 'Isla Patrulla' },
     { id: '340', state: 'Treinta y Tres', name: 'Treinta y Tres' },
     { id: '341', state: 'Treinta y Tres', name: 'Tupambae' },
     { id: '342', state: 'Treinta y Tres', name: 'Vergara' },
     { id: '343', state: 'Montevideo', name: 'Golf' },
     { id: '345', state: 'Canelones', name: 'San José de Carrasco' },
     { id: '346', state: 'Lavalleja', name: 'Villa del Cerro' },
     { id: '347', state: 'Montevideo', name: 'La Caleta' },
     { id: '348', state: 'Internacional', name: 'Miami' },
     { id: '349', state: 'Internacional', name: 'Otras' },
     { id: '350', state: 'Internacional', name: 'Asunción' },
     { id: '351', state: 'Internacional', name: 'Otras' },
     { id: '352', state: 'Internacional', name: 'La Paz' },
     { id: '353', state: 'Internacional', name: 'Santa Cruz' },
     { id: '354', state: 'Internacional', name: 'Otras' },
     { id: '355', state: 'Canelones', name: 'Colonia Nicolich' },
   ]
  end

  def rooms
    [
      { id: '1', name: 'Monoambiente' },
      { id: '2', name: '1 dormitorio' },
      { id: '3', name: '2 dormitorios' },
      { id: '4', name: '3 dormitorios' },
      { id: '5', name: '4 dormitorios' },
      { id: '6', name: '5 o más dormitorios' },
    ]
  end

  def statuses
    [
      { id: '1', name: 'A estrenar' },
      { id: '2', name: 'Recilada' },
      { id: '3', name: 'Excelente estado' },
      { id: '4', name: 'Buen estado' },
      { id: '5', name: 'Requiere mantenimineto' },
      { id: '6', name: 'A reciclar' },
      { id: '7', name: 'Sin definir' },
      { id: '9', name: 'En construcción' }
    ]
  end

  def comodities
    [
      { id: '1', name: 'Calefacción' },
      { id: '2', name: 'Garage' },
      { id: '3', name: 'Parrillero' },
      { id: '4', name: 'Balcón' },
      { id: '5', name: 'Patio' },
      { id: '6', name: 'Recreación' },
      { id: '7', name: 'Amueblada' },
      { id: '8', name: 'Lavandería' },
      { id: '9', name: 'Piscina' }
    ]
  end

  def bathrooms
    [
      { id: '1', name: '1 baño' },
      { id: '2', name: '2 baños' },
      { id: '3', name: '3 o más baños' }
    ]
  end

  def dispositions
    [
      { id: '1', name: 'No aplica' },
      { id: '2', name: 'Al frente' },
      { id: '3', name: 'Contrafrente' },
      { id: '4', name: 'Interior' },
      { id: '5', name: 'Lateral' }
    ]
  end

  def sea_distances
    [
      { id: '1', name: 'Frente al mar' },
      { id: '2', name: 'Menos de 100 m'},
      { id: '3', name: '200 m'},
      { id: '4', name: '300 m'},
      { id: '5', name: '400 m'},
      { id: '6', name: '500 m'},
      { id: '7', name: 'Menos de 1.000 m'},
      { id: '8', name: 'Más de 1.000 m'}
    ]
  end

  def security_types
    [
      { id: '1', name: 'Seguridad'}
    ]
  end

  def filters_order
    [
      { id: 0, name: 'Mayor Precio'},
      { id: 1, name: 'Menor Precio'},
      { id: 2, name: 'Relevancia'},
      { id: 3, name: 'Últimos Ingresos'},
      { id: 4, name: 'Menor m²'},
      { id: 5, name: 'Mayor m²'}
    ]
  end

  def listing_types
    [
      { id: 0, name: 'Propiedad común' },
      { id: 1, name: 'Conjunto de propiedades agrupadas' },
      { id: 2, name: 'Proyecto' }
    ]
  end
end
