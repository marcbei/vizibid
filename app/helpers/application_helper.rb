module ApplicationHelper

    def signed_in_user
      redirect_to signin_path, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def correct_user_with_id(id)
      @user = User.find(id)
      redirect_to(root_path) unless current_user?(@user)
    end

    def options_for_comment_sort
       [
        ['Top', 'Top'],
        ['Newest', 'Newest'],
        ['Oldest', 'Oldest'],
       ]
    end

     def us_states
      [  
      	['Any', 'Any'], 
        ['Alabama', 'Alabama'],
        ['Alaska', 'Alaska'],
        ['Arizona', 'Arizona'],
        ['Arkansas', 'Arkansas'],
        ['California', 'California'],
        ['Colorado', 'Colorado'],
        ['Connecticut', 'Connecticut'],
        ['Delaware', 'Delaware'],
        ['District of Columbia', 'District of Columbia'],
        ['Florida', 'Florida'],
        ['Georgia', 'Georgia'],
        ['Hawaii', 'Hawaii'],
        ['Idaho', 'Idaho'],
        ['Illinois', 'Illinois'],
        ['Indiana', 'Indiana'],
        ['Iowa', 'Iowa'],
        ['Kansas', 'Kansas'],
        ['Kentucky', 'Kentucky'],
        ['Louisiana', 'Louisiana'],
        ['Maine', 'Maine'],
        ['Maryland', 'Maryland'],
        ['Massachusetts', 'Massachusetts'],
        ['Michigan', 'Michigan'],
        ['Minnesota', 'Minnesota'],
        ['Mississippi', 'Mississippi'],
        ['Missouri', 'Missouri'],
        ['Montana', 'Montana'],
        ['Nebraska', 'Nebraska'],
        ['Nevada', 'Nevada'],
        ['New Hampshire', 'New Hampshire'],
        ['New Jersey', 'New Jersey'],
        ['New Mexico', 'New Mexico'],
        ['New York', 'New York'],
        ['North Carolina', 'North Carolina'],
        ['North Dakota', 'North Dakota'],
        ['Ohio', 'Ohio'],
        ['Oklahoma', 'Oklahoma'],
        ['Oregon', 'Oregon'],
        ['Pennsylvania', 'Pennsylvania'],
        ['Puerto Rico', 'Puerto Rico'],
        ['Rhode Island', 'Rhode Island'],
        ['South Carolina', 'South Carolina'],
        ['South Dakota', 'South Dakota'],
        ['Tennessee', 'Tennessee'],
        ['Texas', 'Texas'],
        ['Utah', 'Utah'],
        ['Vermont', 'Vermont'],
        ['Virginia', 'Virginia'],
        ['Washington', 'Washington'],
        ['West Virginia', 'West Virginia'],
        ['Wisconsin', 'Wisconsin'],
        ['Wyoming', 'Wyoming']
       ] 
   end

end
