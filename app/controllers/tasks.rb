get '/' do
  redirect '/tasks'
end

get '/tasks' do
  erb :'index'
end

post '/tasks' do
  url = params[:url]
  page = Nokogiri::HTML(open(url))
  links = page.css("a")

  task_texts = []
  links.each do |link|
    task_texts << "[#{link.text}](#{link["href"]})"
  end

  task_texts.each do |task_text|
    habit = HabiticaClient.new(ENV['USER_ID'], ENV['API_TOKEN'])
    .tasks.create(
      text: task_text,
      type: 'todo'
    )
  end
  redirect 'https://habitica.com/#/tasks'
end
