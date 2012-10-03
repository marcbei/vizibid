class FormsController < ApplicationController
  
  before_filter :signed_in_user

  def create
  	@form = Form.new(params[:form])
    @form.user_id = current_user.id
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
    @newform = Form.new

    @inappropriate_document_report = InappropriateDocument.find_by_user_id_and_form_id(current_user.id, @form.id)
    @id = InappropriateDocument.new

  end

  def download
    @form = Form.find(params[:id])
    
    @formdownload = FormDownload.new
    @formdownload.user_id = current_user.id
    @formdownload.form_id = @form.id
    @formdownload.save

    redirect_to @form.form.url
  end

end