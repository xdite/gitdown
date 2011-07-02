class PagesController < ApplicationController
  
  before_filter :find_data
  
  def show
    unless @data
      @wiki = Wiki.new(:name => params[:page_name])
      render :new
    end
  end
  
  def update
    @wiki = Wiki.new(params[:wiki])
    gollum.update_page(@data, @wiki.name,:markdown,@wiki.content)
    redirect_to "/#{CGI.escape(@wiki.name)}"
  end
  
  def create
    @wiki = Wiki.new(params[:wiki])
    @data =  gollum.page(@wiki.name)
    begin
      gollum.write_page(@wiki.name, :markdown, @wiki.content)
      redirect_to "/#{CGI.escape(@wiki.name)}"
    rescue Gollum::DuplicatePageError => e
      render :text => "Duplicate page: #{e.message}"
    end
  end
  
  def edit
    gollum_wiki = gollum.page(params[:page_name])
    @data =  gollum.page(params[:page_name])
    @wiki = Wiki.new(:name => params[:page_name], :content => @data.raw_data)
  end
  
  def index
    @data = gollum.page('Home')
    render :action => :show
  end
  
  protected
  
  def find_data
    @data =  gollum.page(params[:page_name]) || gollum.page(params[:id])
  end
  
end
