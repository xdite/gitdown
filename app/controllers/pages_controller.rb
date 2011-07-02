class PagesController < ApplicationController
  
  before_filter :find_data, :only => [:show,:update, :edit]
  
  def show
    unless @data
      @wiki = Wiki.new(:name => params[:page_name])
      render :new
    end
  end
  
  def update
    if @data.update_attributes(params[:wiki])
      redirect_to "/#{CGI.escape(@data.name)}"
    else
      render :edit
    end
  end
  
  def create
    @wiki = Wiki.new(params[:wiki])
    begin
      @wiki.save
      redirect_to "/#{CGI.escape(@wiki.name)}"
    rescue Gollum::DuplicatePageError => e
      render :text => "Duplicate page: #{e.message}"
    end
  end
  
  def new
  end
  
  def edit
    @wiki = Wiki.find(params[:page_name]) 
  end
  
  def index
  
  end
  
  def welcome
    @data = Wiki.find('Home')
    render :action => :show
  end
  
  protected
  
  def find_data
    @data =  Wiki.find(params[:page_name]) || Wiki.find(params[:id])
  end
  
end
