class ArticlesController < ApplicationController
  before_action :set_article, only: %i(show edit update destroy)

  def index
    user = User.first
    @articles = user.articles
  end

  def show; end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new article_params

    respond_to do |format|
      if @article.save
        format.html do
          redirect_to article_url(@article),
                      notice: "Article was successfully created."
        end
        format.json{render :show, status: :created, location: @article}
      else
        format.html{render :new, status: :unprocessable_entity}
        format.json do
          render json: @article.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update article_params
        format.html do
          redirect_to article_url(@article),
                      notice: "Article was successfully updated."
        end
        format.json{render :show, status: :ok, location: @article}
      else
        format.html{render :edit, status: :unprocessable_entity}
        format.json do
          render json: @article.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @article.destroy

    respond_to do |format|
      format.html do
        redirect_to articles_url,
                    notice: "Article was successfully destroyed."
      end
      format.json{head :no_content}
    end
  end

  private
  def set_article
    @article = Article.find params[:id]
  end

  def article_params
    params.require(:article).permit :title, :body, :status, :user_id
  end
end
