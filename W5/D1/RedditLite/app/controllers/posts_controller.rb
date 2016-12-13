class PostsController < ApplicationController
  before_action :require_user!

  def new

    @post = Post.new
    render :new
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def create
    @post = Post.new(post_params)
    if @post.save!
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub_id)
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :url, :sub_id, :author_id)
  end

end
