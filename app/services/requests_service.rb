class RequestsService
  attr_accessor :base_url, :api_key

  def initialize(user_agent)
    self.base_url = ENV['api_base_url']
    self.api_key = ENV['api_key']
    @user_agent = user_agent
  end

  def user_agent
    @user_agent
  end

  def home_banner
    begin
      response = HTTParty.get("#{base_url}/featured", headers: { 'Infocasas-API-KEY': api_key, 'X-User-Agent': user_agent })
      result = JSON.parse(response.body)['result']
      banner = {}
      banner[:bannerHome] = result['bannerHome'][rand(0..(result['bannerHome'].length) - 1)]
      banner[:bannerCuadrado] = result['bannerCuadrado']
      banner[:cajaLinks] = result['cajaLinks']
      banner
    rescue
      return {}
    end
  end

  def home_banners
    begin
      response = HTTParty.get("#{base_url}/banners", headers: { 'Infocasas-API-KEY': api_key, 'X-User-Agent': user_agent })
      JSON.parse(response.body)['result'] || response
    rescue
      return {}
    end
  end

  # properties service

  def highlighted_properties(type)
    begin
      response = HTTParty.get("#{base_url}/properties/destacadas", headers: { 'Infocasas-API-KEY': api_key, 'X-User-Agent': user_agent } , query: { minResults: 6 , IDoperaciones: type })
      JSON.parse(response.body)['result']
    rescue
      return {}
    end
  end

  def landing_links
    begin
      response = HTTParty.get("#{base_url}/seo/cajadelinks/portada", headers: { 'Infocasas-API-KEY': api_key, 'X-User-Agent': user_agent })
      JSON.parse(response.body)['result']
    rescue
      return {}
    end
  end

  def properties_listing(params)
    begin
      response = HTTParty.get("#{base_url}/properties/search", headers: { 'Infocasas-API-KEY': api_key, 'X-User-Agent': user_agent }, query: params)
      JSON.parse(response.body)['result'] || response
    rescue
      return {}
    end
  end

  def property(id)
    begin
      response = HTTParty.get("#{base_url}/properties/#{id}", headers: { 'Infocasas-API-KEY': api_key, 'X-User-Agent': user_agent }, query: { pa: 1 })
      JSON.parse(response.body)['result'] || response
    rescue
      return {}
    end
  end

  def project(id)
    begin
      response = HTTParty.get("#{base_url}/properties/ampliarproyecto/#{id}", headers: { 'Infocasas-API-KEY': api_key, 'X-User-Agent': user_agent })
      JSON.parse(response.body)['result'] || response
    rescue
      return {}
    end
  end

  def consult(id, params)
    begin
      body_params = {}
      body_params[:nombre] = params[:name]
      body_params[:email] = params[:email]
      body_params[:telefono] = params[:phone]
      body_params[:consulta] = params[:question]
      body_params[:deProyecto] = true if params[:listing_type] == '2'
      body_params[:temporal] = params[:rent] if params[:rent].present?
      response = HTTParty.post("#{base_url}/properties/#{id}/ask", headers: { 'Infocasas-API-KEY': api_key, 'X-User-Agent': user_agent }, body: body_params)
      if response['result'].present?
        { success: "¡Tu consulta fue enviada con éxito!" }
      else
        { error: "Ocurrio un error. Esto puede deberse a que usted ya realizo la consulta." }
      end
    rescue
      return {}
    end
  end

  def consult_express(id, params)
    begin
      body_params = {}
      body_params[:nombre] = params[:name]
      body_params[:email] = params[:email]
      body_params[:telefono] = params[:phone]
      body_params[:automatica] = params[:query_name]
      body_params[:deProyecto] = true if params[:listing_type] == '2'
      body_params[:temporal] = params[:rent] if params[:rent].present?
      response = HTTParty.post("#{base_url}/properties/#{id}/askexpress", headers: { 'Infocasas-API-KEY': api_key, 'X-User-Agent': user_agent }, body: body_params)
      if response['result'].present?
        { success: "¡Tu consulta fue enviada con éxito!" }
      else
        { error: "Ocurrio un error. Esto puede deberse a que usted ya realizo la consulta" }
      end
    rescue
      return {}
    end
  end

  def reference_search(ref)
    begin
      response = HTTParty.get("#{base_url}/properties/search/#{ref}", headers: { 'Infocasas-API-KEY': api_key, 'X-User-Agent': user_agent })
     JSON.parse(response.body)['result']['id'] || response
    rescue
      return {}
    end
  end

  def property_images(id)
    begin
      response = HTTParty.get("#{base_url}/properties/#{id}/getimages", headers: { 'Infocasas-API-KEY': api_key, 'X-User-Agent': user_agent })
      JSON.parse(response.body)['result'] || response
    rescue
      return {}
    end
  end

  def similar_properties(id, id_operation)
    begin
      response = HTTParty.post("#{base_url}/properties/#{id}/similar", headers: { 'Infocasas-API-KEY': api_key, 'X-User-Agent': user_agent }, body: { 'IDoperacion': id_operation })
      JSON.parse(response.body)['result'] || response
    rescue
      return {}
    end
  end

  # ubications service

  def ubications(params)
    begin
      response = HTTParty.get("#{base_url}/ubications/nearby", headers: { 'Infocasas-API-KEY': api_key, 'X-User-Agent': user_agent }, query: params)
      JSON.parse(response.body)['result'] || response
    rescue
      return {}
    end
  end

  # users service

  def newsletter_subscribe(email)
    begin
      response = HTTParty.post("#{base_url}/users/suscribe", headers: { 'Infocasas-API-KEY': api_key, 'X-User-Agent': user_agent }, body: { email: email })
      response['result'].present? ? { success: "¡Suscrito con éxito!" } : { error: "Ocurrio un error. Por favor pruebe más tarde." }
    rescue
      return {}
    end
  end

  def contact(params)
    begin
      body_params = {}
      body_params[:email] = params[:email]
      body_params[:nombre] = params[:name]
      body_params[:mensaje] = params[:question]
      body_params[:telefono] = params[:phone] if params[:phone].present?
      response = HTTParty.post("#{base_url}/contact", headers: { 'Infocasas-API-KEY': api_key, 'X-User-Agent': user_agent }, body: body_params)
      if response['result'].present?
        { success: "¡Enviado!" }
      else
        { error: "Ocurrio un error. Por favor pruebe más tarde." }
      end
    rescue
      return {}
    end
  end
end
