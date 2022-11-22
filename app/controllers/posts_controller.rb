class PostsController < ApplicationController
  before_action :create_posts_service

  def index
    request_params = {}
    request_params[:pageToken] = params[:page_token] if params[:page_token].present?
    @blog = @posts_service.posts(request_params)
    @posts = @blog['items']
  end

  def show
    @post = @posts_service.post(params[:id])
  end

  private

  def create_posts_service
    @posts_service = PostsService.new
  end
end
