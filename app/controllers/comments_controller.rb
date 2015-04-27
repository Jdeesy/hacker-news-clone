class CommentsController < ApplicationController

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @author = @comment.user
    if @author == current_user
      render 'edit'
    else
      redirect_to root_path
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post
    @comment.save
    redirect_to @post
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @author = @comment.user
    if @author == current_user && @comment.update_attributes(comment_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    @author = @comment.user
    @comment.destroy if @author == current_user
    redirect_to @post
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

end
