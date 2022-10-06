class ArticlesController < ApplicationController

    before_action :set_article, only: [:show, :edit, :update, :destroy] # Only works for this methods

    def show
       # binding.break #debug gem
       # @article = Article.find(params[:id]) # Doesn't need to set the attribute anymore, because it's set in private method
    end

    def index
        @articles = Article.all
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
end