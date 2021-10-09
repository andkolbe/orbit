module SessionsHelper
    def log_in(user)
        # creates an encrypted session cookie off of the id of the user
        session[:user_id] = user.id
    end

    def current_user
        if session[:user_id]
            # If @current_user is nil or false, it will be set to User.find_by_id(session[:user_id])
            @current_user ||= User.find_by(id: session[:user_id]) 
        end
    end
    
    def logged_in? # you are logged in if the current user is not nil
        !current_user.nil?
    end

    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
end

# a ||= b is equivalent to a = a || b
# same as a = b unless a