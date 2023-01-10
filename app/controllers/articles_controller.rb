class ArticlesController < ApplicationController
  
  
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  
  def index
    # fetch all articles from the database:
    @articles = Article.all 
  end

  # show will render app/views/articles/show.html.erb
  def show 
    @article = Article.find(params[:id])
  end

  # instantiates a new article but does not save it
  def new
    @article = Article.new 
  end 

  # create instantiates a new article with values for 
  # the title and body and attempts to save it
  def create 
    @article = Article.new(article_params)
    
    if @article.save
      redirect_to @article 
    else 
      render :new, status: :unprocessable_entity
    end 
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
  
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end

end
