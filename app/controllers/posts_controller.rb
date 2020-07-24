class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    @timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user)
    my_friends = friend_search { |friend| friend[1] == true }
    my_friends << current_user.id
    @timeline_posts = @timeline_posts.select { |post| my_friends.include?(post.user_id) }
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
