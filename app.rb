require 'bundler/setup'
Bundler.require(:default)

require 'sinatra'
require 'json'
require 'sqlite3'
require_relative 'user_manager'

enable :sessions

set :views, './views'

before do
  @user_manager = UserManager.new
end

post '/users' do
  user_data = [params[:firstname], params[:lastname], params[:age].to_i, params[:password], params[:email]]
  new_user_id = @user_manager.add_user(user_data)
  user = @user_manager.get_user(new_user_id)
  user.reject! { |key| key == 'password' }
  user.to_json
end

get '/users' do
  users = @user_manager.fetch_all_users
  users.each { |user| user.delete('password') }
  users.to_json
end

get '/users/:id' do
  user_id = params[:id].to_i
  user = @user_manager.get_user(user_id)
  if user
    user.reject! { |key| key == 'password' }
    user.to_json
  else
    status 404
    { error: 'User not found' }.to_json
  end
end

put '/users' do
  if session[:user_id]
    user_id = session[:user_id]
    @user_manager.change_user_password(user_id, params[:new_password])
    user = @user_manager.get_user(user_id)
    user.reject! { |key| key == 'password' }
    user.to_json
  else
    status 401
    { error: 'Not logged in' }.to_json
  end
end

post '/sign_in' do
  user = @user_manager.find_user_by_email(params[:email])
  if user && user['password'] == params[:password]
    session[:user_id] = user['id']
    user.reject! { |key| key == 'password' }
    status 200
    { message: 'User signed in', user: user }.to_json
  else
    status 401
    { error: 'Invalid credentials' }.to_json
  end
end

delete '/sign_out' do
  session.clear
  status 204
end

delete '/users/:id' do
  if session[:user_id]
    user_id = params[:id].to_i
    @user_manager.delete_user(user_id)
    session.clear  
    status 204  # No content
  else
    status 401  # Unauthorized
    { error: 'Not logged in' }.to_json
  end
end

delete '/users' do
  if session[:user_id]
    user_id = session[:user_id]
    @user_manager.delete_user(user_id)
    session.clear
    status 200
    { message: 'User deleted' }.to_json
  else
    status 401
    { error: 'Not logged in' }.to_json
  end
end

get '/' do
  erb :index
end
