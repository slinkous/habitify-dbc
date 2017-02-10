get '/' do
  redirect '/tasks'
end

get '/tasks' do
  erb :'index'
end

post '/tasks' do
  require 'open-uri'
  url = params[:url]
  page = Nokogiri::HTML(open(url))
  fragment = page.css('article.markdown-body')
  links = fragment.css("a")
  puts links

  task_texts = []
  links.each do |link|
    task_texts << "[#{link.text}](#{link["href"]})"
  end
  puts task_texts
  task_texts.each do |task_text|
    habit = HabiticaClient.new(ENV['USER_ID'], ENV['API_TOKEN'])
    habit.tasks.create(
      text: task_text,
      type: 'todo'
    )
  end
  redirect "https://habitica.com/"
end
