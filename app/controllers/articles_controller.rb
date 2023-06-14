class ArticlesController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :load_article, except: %i(index new create)
  before_action :correct_user, only: :destroy

  def index
    user = User.first
    @pagy, @articles = pagy user.articles
  end

  def show; end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    params[:article][:status] = :pending
    @article = current_user.articles.build(article_params)
    @article.image.attach params.dig(:article, :image)
    if @article.save
      flash[:success] = t "articles.new.success"
      redirect_to root_path
    else
      @pagy, @feed_items = pagy current_user.feed
      render "welcome/index"
    end
  end

  def update
    respond_to do |format|
      if @article.update article_params
        format.html do
          redirect_to article_path @article
        end
      else
        format.html{render :edit, status: :unprocessable_entity}
        format.json do
          render json: @article.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = t "articles.delete.success"
      redirect_to request.referer || root_url
    else
      flash[:error] = t "articles.delete.failed"
      redirect_to root_path
    end
  end

  private
  def load_article
    @article = Article.find_by id: params[:id]
    return if @article

    flash[:danger] = t "articles.new.not_found"
    redirect_to root_path
  end

  def article_params
    params.require(:article).permit :title, :body, :status, :image
  end

  def correct_user
    @article = current_user.articles.find_by id: params[:id]
    return if @article

    flash[:danger] = t "articles.new.not_found"
    redirect_to root_path
  end
end
