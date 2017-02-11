get '/users/new' do 
	erb :'_registration'
end

post '/users' do
	redirect '/'
end