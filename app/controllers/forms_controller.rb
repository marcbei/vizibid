class FormsController < ApplicationController

  include FormHelper
  
  before_filter :signed_in_user
  
  def create

    # handle the case where the form is a assoicated with a request
    if(params[:requestid] != nil)
      # maybe this makes more sense to be in form_requests controller
      save_request(params)
    # this handles an uploaaded form not associated with a request
    else
      save_form(params[:form])
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

    if @form.approved == false
      render :status => 404
      return
    end

    @comments = @form.comments
    @comment = current_user.comments.build
    @user = @form.user.name
    @newform = Form.new

    @inappropriate_document_report = InappropriateDocument.find_by_user_id_and_form_id(current_user.id, @form.id)
    @id = InappropriateDocument.new

    @pemitted_user = check_permissions(@form)

    respond_to do |format|
          format.js  
          format.html
      end

  end

  def download
    @form = Form.find(params[:id])
    @form_file_name = File.basename(@form.form.to_s.split('?')[0])
    
    @formdownload = FormDownload.new(:user_id => current_user.id, :form_id => @form.id)
    @formdownload.save

    open(@form.form.url) {|form|
      tmpfile = Tempfile.new("temp#{@form_file_name}")
      File.open(tmpfile.path, 'wb') do |f| 
        f.write form.read
      end 
      send_file tmpfile.path, :filename =>  @form_file_name
    }

    if current_user.user_notification.downloads == true && current_user.id != @form.user.id
      Mailer.delay.doc_download_mail(current_user, @form)  
    end  
  end
end