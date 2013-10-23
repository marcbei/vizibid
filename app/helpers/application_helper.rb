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

    def practice_areas
    [
        ['Administrative', 1],
        ['Admiralty', 2],
        ['Antitrust', 3],
        ['Arbitration', 4],
        ['Appellate', 5],
        ['Aviation', 6],
        ['Banking', 7],
        ['Bankruptcy', 8],
        ['Business/Corporate', 9],
        ['Civil Rights', 10],
        ['Collection', 11],
        ['Communication', 12],
        ['Construction', 13],
        ['Consumer Claims', 14],
        ['Criminal', 15],
        ['Employment', 16],
        ['Employee Benefits/ERISA', 17],
        ['Entertainment', 18],
        ['Environmental', 19],
        ['Estate Planning', 20],
        ['Family/Domestic/Divorce', 21],
        ['Health Care', 22],
        ['Immigration', 23],
        ['Insurance', 24],
        ['Intellectual Property', 25],
        ['International', 26],
        ['Investment Counseling/Money Management', 27],
        ['Labor', 28],
        ['Law Practice Management', 29],
        ['Litigation (General)', 30],
        ['Mediation', 31],
        ['Municipal/Governmental', 32],
        ['Personal Injury', 33],
        ['Probate', 34],
        ['Real Estate', 35],
        ['School', 36],
        ['Securities', 37],
        ['Social Security', 38],
        ['Tax', 39],
        ['Water Rights', 40],
        ['Workers Compensation', 41]
    ]
    end

    def options_for_state_licensed
    [
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

    def delete_comment(comment)
        parent = comment.parent
        comment.destroy
        
        if parent != nil && parent.content == "[Deleted]" && parent.is_childless?
            parent.destroy
        else
            comment.destroy
        end
    end

    def check_permissions(form)

        allowed =false

        user_pay = false
        user_nonpay = false
        user_special = false
        form_special = false

        if form != nil
            current_user.user_permissions.each{|u| 
                if u.role_id == 2 
                    user_pay = true
                elsif u.role_id == 1
                    user_nonpay = true
                elsif u.role_id == 3
                      user_special = true
                end
            }

            form.form_permissions.each{|p| 
                if p.role_id == 3
                    form_special = true
                end
            }

            if form_special == true && user_special == true
                allowed = true
            elsif user_pay == true
                allowed = true
            end

        else
            current_user.user_permissions.each{|p| 
                if p.role_id == 2 
                    user_pay = true 
                    break
                end
            }

            if user_pay == true
                allowed = true
            end

        end

        return allowed
    end
end
