class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @author = @post.user
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
    @author = @post.user
    if @author == current_user
      render 'edit'
    else
      redirect_to root_path
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    @author = @post.user
    if @author == current_user && @post.update_attributes(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @author = @post.user
    @post.destroy if @author == current_user
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
