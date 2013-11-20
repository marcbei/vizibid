class FormsController < ApplicationController

  include FormHelper
  
  before_filter :signed_in_user
  
  def index

    @subscribedformrequests = Array.new
    UserPracticeArea.find(:all, :conditions => ["user_id = '#{current_user.id}'"]).each{|pa| @subscribedformrequests = @subscribedformrequests + pa.practice_area.form_requests}

    @subscribedforms = Array.new
    UserPracticeArea.find(:all, :conditions => ["user_id = '#{current_user.id}'"]).each{|pa| @subscribedforms = @subscribedforms + pa.practice_area.forms}

    if params[:sort] == "newest"
      @items = (@subscribedformrequests + @subscribedforms).sort_by(&:created_at).reverse
    elsif params[:sort] == "activity"
      @items = (@subscribedformrequests + @subscribedforms).sort_by(&:updated_at).reverse
    end

    respond_to do |format|
      format.js
    end

  end

  def create

    # handle the case where the form is a assoicated with a request
    if (params[:form][:origin] != "" && params[:form][:origin] != nil)
      @form = Form.new(params[:form])
      @form.user_id = current_user.id
      @form.description = params[:form][:description]
      @form.jurisdiction = params[:form][:jurisdiction]
      @form.practice_area_id = params[:form][:practice_area_id]
      @form.origin = params[:form][:origin]
      @form.seed = true

      if @form.save 
        flash[:message] = "form saved"
      else
        flash[:message] = "form not saved"
      end

      redirect_to uploadpage_path
    elsif(params[:requestid] != nil)
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

    FormView.create(:user_id => current_user.id, :form_id => params[:id])

    @comments = @form.comments
    @comment = current_user.comments.build
    @user = @form.user.name
    @followingForm = FormFollow.find_by_form_id_and_user_id(params[:id], current_user.id)
    if @followingForm == nil
      @following = false
    else
      @following = true
    end

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
    
    if @form.user.id != current_user.id
      @formdownload = FormDownload.new(:user_id => current_user.id, :form_id => @form.id)
      @formdownload.save
    end

    begin
      open(@form.form.url) {|form|
        tmpfile = Tempfile.new("temp#{@form_file_name}")
        File.open(tmpfile.path, 'wb') do |f|
          f.write form.read
        end

        File.open(tmpfile.path, 'wb') do |f|
          while line = f.gets
            puts line
            if line.contains? "HTTP/1.1 500 Internal Server Error"
              raise
            end
          end
        end 

        send_file tmpfile.path, :filename =>  @form_file_name
      }
    rescue
      open(@form.form.url) {|form|
        tmpfile = Tempfile.new("temp#{@form_file_name}")
        File.open(tmpfile.path, 'wb') do |f| 
          f.write form.read
        end 
        send_file tmpfile.path, :filename =>  @form_file_name
      }
    end

    if current_user.user_notification.downloads == true && current_user.id != @form.user.id
      Mailer.delay.doc_download_mail(current_user, @form)  
    end  
  end

  def upload_special

    @f = Form.new

  end

end