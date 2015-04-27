class CommentsController < ApplicationController

  def edit
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
    if @comment.save
      redirect_to @post
    else
      render 'post/show'
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @author = @comment.user
    if @author == current_user && @comment.update_attributes(comment_params)
      redirect_to @comment
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @author = @comment.user
    @comment.destroy if @author == current_user
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

end
