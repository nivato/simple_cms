class SubjectsController < ApplicationController
  
  layout("admin")
  before_filter :confirm_logged_in
  
  def index
    list
    render "list"
  end
  
  def list
    @subjects = Subject.sorted
  end
  
  def show
    @subject = Subject.find(params[:id])
  end
  
  def new
    @subject = Subject.new(:name =>"default")
    @subject_count = Subject.count + 1
  end
  
  def create
    new_position = params[:subject].delete(:position)
    @subject = Subject.new(params[:subject])
    if @subject.save
      @subject.move_to_position(new_position)
      flash[:notice] = "Subject #{@subject.name} created successfully."
      redirect_to(:action => "list")
    else
      @subject_count = Subject.count + 1
      render("new")
    end
  end
  
  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end
  
  def update
    new_position = params[:subject].delete(:position)
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(params[:subject])
      @subject.move_to_position(new_position)
      flash[:notice] = "Subject id=#{@subject.id} updated successfully."
      redirect_to(:action => "show", :id => @subject.id)
    else
      @subject_count = Subject.count
      render("edit")
    end
  end
  
  def delete
    @subject = Subject.find(params[:id])
  end
  
  def destroy
    subject = Subject.find(params[:id])
    subject.move_to_position(nil)
    subject.destroy
    flash[:notice] = "Subject destroyed successfully."
    redirect_to(:action => "list")
  end
  
end
