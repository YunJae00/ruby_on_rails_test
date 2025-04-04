class PostsController < ApplicationController
  include Authenticable

  before_action :authenticate_user, only: [ :create ]

  def index
    @posts = Post.all
    render json: @posts, status: 200, each_serializer: PostSerializers::PostSerializer
  end

  def show
    @post = Post.find(params[:id])
    render json: @post, status: 200, serializer: PostSerializers::PostSerializer
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post
    else
      render json: @post.errors
    end
  end

  def post_params
    params.permit(:title, :content)
  end
end
