class FormsController < ApplicationController
  
  before_filter :signed_in_user
  
  def create

    if(params[:requestid] != nil)

      @request_submission = RequestSubmission.new
      @request_submission.form_request_id = params[:requestid]
      @request_submission.comment = params[:request_submission][:comment]
      @request_submission.user_id = current_user.id
      @request_submission.parent_id = params[:parent_id]
      
      if !@request_submission.save
        flash[:error] = "There was a problem with your submission. Please try again."
        redirect_to form_request_path(params[:requestid])
        return
      end

      @request = FormRequest.find(params[:requestid])
      @requestowner = User.find(@request.user.id)

      if params[:commentonly] == "yes" || params[:form][:name].empty?
        flash[:success] = "Thank you for your contribution!"

        #send mail
        if @requestowner.user_notification.requests == true && current_user.id != @requestowner.id
          Mailer.delay.doc_request_mail(current_user, @request, @requestowner, @request_submission) 
        end

        redirect_to form_request_path(params[:requestid])
        return
      else
        @form = Form.new(params[:form])
        @form.user_id = current_user.id
        @form.description = params[:form][:description]
        @form.jurisdiction = params[:form][:jurisdiction]

        if @form.save
          flash[:success] = "Thank you for your contribution!"
          @request_submission.form_id = @form.id
          @request_submission.save

          #sendmail
          if @requestowner.user_notification.requests == true && current_user.id != @requestowner.id
            Mailer.delay.doc_request_mail(current_user, @request, @requestowner, @request_submission) 
          end

          redirect_to form_request_path(params[:requestid])
        else
          @request_submission.destroy
          flash[:error] = "There was a problem with your submission. Please try again."
          redirect_to form_request_path(params[:requestid])
        end
      end

    else

      @form = Form.new(params[:form])
      @form.user_id = current_user.id
      @form.description = params[:form][:description]
      @form.jurisdiction = params[:form][:jurisdiction]

      if @form.save
        flash[:success] = "Thank you for your contribution!"
        redirect_to form_path(@form.id)
      else
        flash[:error] = "There was a problem with your submission. Please try again."
        redirect_to share_path
      end
    end
  end

  def show

    @sorted = "top"
    if params[:sorted_by] == "new"
      @sort_by = "new"
    elsif params[:sorted_by] == "old"
      @sort_by = "old"
    end 

    @form = Form.find(params[:id])
    @comments = @form.comments
    @comment = current_user.comments.build
    @user = @form.user.name
    @newform = Form.new

    @inappropriate_document_report = InappropriateDocument.find_by_user_id_and_form_id(current_user.id, @form.id)
    @id = InappropriateDocument.new

    respond_to do |format|
          format.js  
          format.html
      end

  end

  def download
    @form = Form.find(params[:id])
    @form_file_name = File.basename(@form.form.to_s)
    
    @formdownload = FormDownload.new
    @formdownload.user_id = current_user.id
    @formdownload.form_id = @form.id
    @formdownload.save

    open(@form.form.url) {|form|
      tmpfile = Tempfile.new("temp#{@form_file_name}")
      File.open(tmpfile.path, 'wb') do |f| 
        f.write form.read
      end 
      send_file tmpfile.path, :filename =>  @form_file_name
    }

    if current_user.user_notification.downloads == true
      Mailer.delay.doc_download_mail(current_user, @form)  
    end  
  end
end