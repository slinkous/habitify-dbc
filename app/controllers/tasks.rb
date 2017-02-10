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
  p page
  links = page.css("a")
  p links

  task_texts = []
  links.each do |link|
    task_texts << "[#{link.text}](#{link["href"]})"
  end
  p task_texts

  task_texts.each do |task_text|
    habit = HabiticaClient.new(ENV['USER_ID'], ENV['API_TOKEN'])
    habit.tasks.create(
      text: task_text,
      type: 'todo'
    )
  end
  redirect 'https://habitica.com/#/tasks'
end
