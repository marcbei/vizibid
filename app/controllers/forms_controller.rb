class FormsController < ApplicationController
  
  before_filter :signed_in_user

  def create
  	@form = Form.new(params[:form])
    @form.user_id = current_user.id
    @form.num_downloads = 0
    @form.description = params[:form][:description]
    @form.jurisdiction = params[:form][:jurisdiction]

    if @form.save

      if(params[:requestid] != nil)

        @request_submission = RequestSubmission.new

        @request_submission.form_request_id = params[:requestid].to_s
        @request_submission.form_id = @form.id
        @request_submission.save
      end

      flash[:success] = "Thank you for your contribution!"
      redirect_to form_path(@form.id)
    else

      flash[:error] = "There was a problem with your submission. Please try again."
      
      if(params[:requestid] != nil)
        redirect_to edit_form_request_path(params[:requestid].to_s)
      else
        redirect_to share_path
      end
    end
  end

  def show
    @form = Form.find(params[:id])
    @comments = @form.comments
    @comment = current_user.comments.build
    @user = @form.user.name
  end

  def download
    @form = Form.find(params[:id])
    @form.num_downloads += 1
    @form.save

    redirect_to @form.form.url
  end

end