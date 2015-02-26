class SessionsController < ApplicationController

def create
  user = User.find_by_email(params[:email])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect_to root_path, notice: 'Welcome back, stranger!'
  else
    @sign_in_error = "Username / password combination is invalid"
    # used to be called where there is a form_for and form_tag because those pages do not have an object,
    #   so they cannot be called upon in the same way as the others. Can't use partials that call upon
    # objects in fields that do not have models and thus do not have objects
    render :new
  end
end


  def destroy
    session.clear
    redirect_to root_path, notice: "We're sorry to see you go!"
  end
end
