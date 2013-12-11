class AnnotationsController < ApplicationController

  respond_to :json
  before_filter :fail_unless_logged_in
  before_filter :load_annotation, only: [:show, :destroy, :update]

  def create
    
  end

  def load_annotation
    if params[:id].nil? or (@ann = Annotation.find params[:id]).nil?
      head :not_found
    end
  end

end
