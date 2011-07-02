class PagesController < ApplicationController
  
  def show
    @content =  wiki.page(params[:page_name]) || wiki.page(params[:id])
    unless @content
      @wiki = Wiki.new(:name => params[:page_name])
      render :new
    end
    
  end
  
  def update
    @content =  wiki.page(params[:page_name]) || wiki.page(params[:id])
    @wiki = Wiki.new(params[:wiki])
    wiki.update_page(@content, @wiki.name,:markdown,@wiki.content)
    redirect_to "/#{CGI.escape(@wiki.name)}"
  end
  
  def create
    @wiki = Wiki.new(params[:wiki])
    @content =  wiki.page(@wiki.name)
    begin
      wiki.write_page(@wiki.name, :markdown, @wiki.content)
      redirect_to "/#{CGI.escape(@wiki.name)}"
    rescue Gollum::DuplicatePageError => e
      render :text => "Duplicate page: #{e.message}"
    end
  end
  
  def edit
    gollum_wiki = wiki.page(params[:page_name])
    @content =  wiki.page(params[:page_name])
    @wiki = Wiki.new(:name => params[:page_name], :content => @content.raw_data)
  end
  
  def index
    @content =  wiki.page('Home').formatted_data
  end
end
