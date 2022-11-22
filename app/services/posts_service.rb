class PostsService
  attr_accessor :blogger_url, :blogger_key, :blog_id

  def initialize
    self.blogger_url = ENV['blogger_base_url']
    self.blogger_key = ENV['blogger_api_key']
    self.blog_id = SITE_CONFIG['blog_id']
  end

  # blogger service

  def blog
    begin
      response = HTTParty.get("#{blogger_url}/blogs/#{blog_id}", query: { 'key': blogger_key })
      JSON.parse(response.body)['result'] || response
    rescue
      return {}
    end
  end

  def posts(params = {})
    begin
      query_params = {}
      query_params[:key] = blogger_key
      query_params[:fetchImages] = true
      query_params[:maxResults] = 12
      query_params[:pageToken] = params[:pageToken] if params[:pageToken]
      response = HTTParty.get("#{blogger_url}/blogs/#{blog_id}/posts", query: query_params)
      JSON.parse(response.body)['result'] || response
    rescue
      return {}
    end
  end

  def post(id)
    begin
      query_params = {}
      query_params[:key] = blogger_key
      query_params[:fetchImages] = true
      query_params[:maxComments] = 10
      response = HTTParty.get("#{blogger_url}/blogs/#{blog_id}/posts/#{id}", query: query_params)
      JSON.parse(response.body)['result'] || response
    rescue
      return {}
    end
  end
end
