class PostsController < ApplicationController
  include Authenticable

  before_action :authenticate_user, only: [ :create, :show ]

  def index
    @posts = Post.all
    render json: @posts, status: 200, each_serializer: PostSerializers::PostSerializer
  end

  def show
    @post = Post.includes(:user).find(params[:id])
    authorize @post
    render json: @post, status: 200, serializer: PostSerializers::PostWithUserSerializer
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      render json: @post, status: 201, serializer: PostSerializers::PostSerializer
    else
      render json: @post.errors, status: 400
    end
  end

  def update
    # @post = Post.eager_load(:user).find(params[:id])
    # @post = Post.preload(:user).find(params[:id])
    @post = Post.includes(:user).find(params[:id])
    if @post.update(post_params)
      render json: @post, status: 200, serializer: PostSerializers::PostWithUserSerializer
    else
      render json: @post.errors, status: 400
    end
  end

  def post_params
    # url에 있는 params 도 포함
    params.permit(:title, :content, :id)
  end
end
