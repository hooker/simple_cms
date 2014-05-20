class PagesController < ApplicationController
	layout "admin" 
	
  def index
  	@pages = Page.sorted
		@subjects = Subject.joins(:pages)
  end

  def show
  	@page = Page.find(params[:id])
  	@subject_name = @page.subject_id ? Subject.find(@page.subject_id).name : ''
  end

  def new
  	@page = Page.new
    @subjects = Subject.order('position ASC')
    @page_count = Page.count + 1
  end
  
  def create
  	@page = Page.new(page_params)
  	if @page.save
  		flash[:notice] = "Page created successfully."
  		redirect_to({:action => 'index'})
  	else
      @subjects = Subject.order('position ASC')
      @page_count = Page.count + 1
  		render('new')
  	end
  end

  def edit
  	@page = Page.find(params[:id])
    @subjects = Subject.order('position ASC')
    @page_count = Page.count
  end
  
  def update
  	@page = Page.find(params[:id])
  	if @page.update_attributes(page_params)
  		flash[:notice] = "Page updated successfully."
  		redirect_to({:action => 'index'})
  	else
      @subjects = Subject.order('position ASC')
      @page_count = Page.count
  		render('edit')
  	end
  end

  def delete
  	@page = Page.find(params[:id])
  end
  
  def destroy
  	page = Page.find(params[:id])
  	page.destroy
  	flash[:notice] = "Page '#{page.name}' deleted successfully."
  	redirect_to({:action => 'index'})
  end
  
  private
  	
  	def page_params 
  		params.require(:page).permit(:name, :position, :permalink, :visible, :subject_id)
  	end
end
