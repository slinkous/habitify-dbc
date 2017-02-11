get '/' do
  redirect '/tasks'
end

get '/tasks' do
  erb :'index'
end

post '/tasks' do
  
  url = params[:url]
  p params[:url]
  page = Nokogiri::HTML(open(url))

  fragment = page.css('article.markdown-body')
  links = fragment.css("a")



  task_texts = []
  links.each do |link|
    task_texts << "[#{link.text}](#{link["href"]})"
  end
  puts task_texts

  try_habitica_client = false

  if try_habitica_client
    habit = HabiticaClient.new("bc0f067b-2bdb-480a-a41e-6b3a81c86861", "656e5497-7d75-4ecf-9bf5-e09614f86715")

   
      # task_texts.each do |task_text|
      #   habit.tasks.create(
      #     text: task_text,
      #     type: 'todo'
      #   )
      # end
    
    redirect "https://habitica.com/"
  else
    @task_texts = task_texts
    erb :'tasks'
  end

  # redirect "https://habitica.com/"
end
