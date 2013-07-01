class PublicController < ApplicationController
  
  layout "public"
  before_filter :setup_navigation
  
  def index
    # intro text
  end

  def show
    @page = Page.where(:subject_id => params[:sbj_id], :permalink => params[:plink], :visible => true).first
    redirect_to(:action => "index") unless @page
  end
  
  private
  
  def setup_navigation
    @subjects = Subject.visible.sorted
  end
  
end
