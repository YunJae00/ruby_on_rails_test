class PostsController < ApplicationController
  include Authenticable

  before_action :authenticate_user, only: [ :create ]

  def index
    @posts = Post.all
    render json: @posts, status: 200, each_serializer: PostSerializers::PostSerializer
  end

  def show
    @post = Post.includes(:user).find(params[:id])
    render json: @post, status: 200, serializer: PostSerializers::PostWithUserSerializer
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    puts(current_user)
    if @post.save
      render json: @post, status: 201, serializer: PostSerializers::PostSerializer
    else
      render json: @post.errors, status: 400
    end
  end

  def post_params
    params.permit(:title, :content)
  end
end
