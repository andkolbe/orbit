module SessionsHelper
    def log_in(user)
        # creates an encrypted session cookie off of the id of the user
        session[:user_id] = user.id
    end
end
