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

  task_texts = {}
  links.each do |link|
    task_texts << "[#{link.text}](#{link["href"]})"
  end
  puts task_texts
  task_datas =[]
  task_texts.each do |text|
    jsonable = {
      type: "todo",
      text: text
    }
    task_datas << jsonable
  end



  # habit = HabiticaClient.new("bc0f067b-2bdb-480a-a41e-6b3a81c86861", "656e5497-7d75-4ecf-9bf5-e09614f86715")

  # begin
  #   task_texts.each do |task_text|
  #     habit.tasks.create(
  #       text: task_text,
  #       type: 'todo'
  #     )
  #   end
  # rescue
  redirect "https://habitica.com/"
end
