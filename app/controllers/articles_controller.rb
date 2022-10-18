class ArticlesController < ApplicationController

    before_action :set_article, only: [:show, :edit, :update, :destroy] # Only works for this methods
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show
       # binding.break #debug gem
       # @article = Article.find(params[:id]) # Doesn't need to set the attribute anymore, because it's set in private method
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def new
        @article = Article.new
    end

    def edit
        #@article = Article.find(params[:id])
    end

    def create
        #render plain: params[:article] # it works sending a json to another page like PHP
        #@article = Article.new(params.require(:article).permit(:title, :description))
        @article = Article.new(article_params)
        @article.user =  current_user
        if @article.save
            flash[:notice] = "Article was created successfully."
        # render plain: @article.inspect
            redirect_to @article
        else
            render 'new'
        end
    end

    def update
        #@article = Article.find(params[:id])
        #if @article.update(params.require(:article).permit(:title, :description))
        if @article.update(article_params)
            flash[:notice] = "Article was update successfully"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        #@article = Article.find(params[:id])
        @article.destroy 
        redirect_to articles_path
    end

    private # All methods under underneath this word will be private
    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description)
    end

    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to articles_path
        end
    end
end