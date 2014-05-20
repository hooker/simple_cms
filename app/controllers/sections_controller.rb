class SectionsController < ApplicationController
	layout "admin"
	
  def index
  	@sections = Section.sorted
  	@pages = Page.joins(:sections)
  end

  def show
  	@section = Section.find(params[:id])
  	@page_name = @section.page_id ? Page.find(@section.page_id).name : ''
  end

  def new
  	@section = Section.new
  end
  
  def create
  	@section = Section.new(section_params)
  	if @section.save
  		flash[:notice] = "Section successfully created."
  		redirect_to({:action => 'index'})
  	else
  		render('new')
  	end
  end

  def edit
  	@section = Section.find(params[:id])
  end
  
  def update
  	@section = Section.find(params[:id])
  	if @section.update_attributes(section_params)
  		flash[:notice] = "Section updated successfully."
  		redirect_to({:action => 'edit', :id => @section.id})
  	else
  		render('edit')
  	end
  end

  def delete
  	@section = Section.find(params[:id])
  end
  
  def destroy
  	section = Section.find(params[:id])
  	section.destroy
  	flash[:notice] = "The section '#{section.name}' was successfully deleted."
  	redirect_to({:action => 'index'})
  end
  
  private
  	
  	def section_params 
  		params.require(:section).permit(:name, :position, :visible, :content_type, :context, :page_id)
  	end
end
