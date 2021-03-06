  require "cgi"

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

    if (params[:form][:origin] != "" && params[:form][:origin] != nil)
      @form = Form.new(params[:form])
      @form.user_id = current_user.id
      @form.description = params[:form][:description]
      @form.jurisdiction = params[:form][:jurisdiction]
      @form.practice_area_id = params[:form][:practice_area_id]
      @form.origin = params[:form][:origin]
      @form.seed = true

      if @form.save 
        flash[:message] = "docment saved"
      else
        flash[:message] = "document not saved"
      end

      redirect_to uploadpage_path
    elsif(params[:requestid] != nil)
      # requests require a form
      if(params[:form] == nil)
        flash[:error] = "There was a problem with your submission. Please try again."
        redirect_to root_path
      else
        save_request(params, params[:urlreq])
      end
    else
      save_form(params[:form], params[:url])
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

    if current_user.download_allocation <= 0 && @form.user.id != current_user.id
      flash[:error] = "You do not have any downloads remaining. Upload a document to get 5 additional downloads."
      redirect_to form_path(params[:id])
      return
    end

    @form_file_name = File.basename(@form.url.to_s.split('?')[0])
    
    if @form.user.id != current_user.id
      @formdownload = FormDownload.new(:user_id => current_user.id, :form_id => @form.id)
      @formdownload.save
    end

    puts "Download: " + @form.url
    puts URI.escape(@form.url)

    file = @form.url.split('/')[-1]
    file_esc = CGI::escape(file)
    url = @form.url.gsub(file, file_esc)

    tmpfile = Tempfile.new("temp#{@form.id}")
    open(url) {|form|
      File.open(tmpfile.path, 'wb') do |f|
        f.write form.read
      end
    }

  if @form.user.id != current_user.id
     User.transaction do
      u = User.find(current_user.id)
      u.lock!
      u.save!
      u.download_allocation = u.download_allocation - 1
      u.save
      sign_in u
     end
  end
   
   send_file tmpfile.path, :filename =>  @form_file_name

  end

  def upload_special

    @f = Form.new

  end

  def destroy
    @form = Form.find(params[:id])
    @form_views = FormView.find_all_by_form_id(params[:id])
    @form_follows = FormFollow.find_all_by_form_id(params[:id])

    if @form.user.id == current_user.id
      @form.destroy

      @form_follows.each do |ff|
        ff.destroy
      end

      @form_views.each do |fv|
        fv.destroy
      end

      flash[:success] = "document deleted"
    else
      flash[:error] = "unable to delete the document"
    end

    redirect_to root_path
  end

end