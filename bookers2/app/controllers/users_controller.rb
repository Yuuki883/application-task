class UsersController < ApplicationController
	before_action :authenticate_user!

  def show
	@user = User.find(params[:id])
	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
	@books = @user.books
  end

  def index
	@user = User.find(current_user.id)
	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def edit
	@user = User.find(params[:id])
	if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
	@user = User.find(params[:id])
	@user.update(user_params)
	if @user.save
		redirect_to user_path(@user), notice: "successfully updated user!"
	else
		render "edit"
	end
  end

  def following
      @user  = User.find(params[:id])
      @users = @user.followings
      render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private
  def user_params
	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
  def baria_user
  unless params[:id].to_i == current_user.id
	redirect_to user_path(current_user)
	end
   end

end