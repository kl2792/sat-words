require 'sinatra'
require 'csv'
require 'json'

get '/' do
  csv = CSV.open('words.csv')
  today = Date.today.strftime('%m/%d/%y')
  @word = csv.find {|word| word[0] === today}
  
  erb :index if @word
  "There is no SAT Word of the Day today."
end

get '/sat-word.js' do
  content_type 'text/javascript', :charset => 'utf-8'
  csv = CSV.open('words.csv')
  today = Date.today.strftime('%m/%d/%y')
  @word = csv.find {|word| word[0] === today}
  
  erb :js, :layout => false
end

__END__

@@ layout
<html>
  <head>
    <title>SAT Word of the Day for <%= @word [0]%></title>
    <style>
      body {font-family: Helvetica, Arial, "MS Trebuchet", sans-serif;}
    </style>
  </head>
  <body>
    <%= yield %>
  </body>
</html>
  
@@ index
<h1><%= @word[1] %></h1>
<p>(<em><%= @word[2] %></em>) &rarr; <%= @word[3] %></p>
<p><em><%= @word[4] %></em></p>
  
@@ js
(function satWord($){
  var word, formattedWord;
  word = {
    date: "<%= @word[0] %>",
    word: "<%= @word[1] %>",
    partOfSpeech: "<%= @word[2] %>",
    definition: "<%= @word[3] %>",
    sentence: "<%= @word[4] %>"
  }
  
  formattedWord = "<h2>SAT Word of the Day</h2>\n";
  formattedWord += "<p>(<em>" + word.partOfSpeech + "</em>) &rarr; ";
  formattedWord += word.definition + "</p>\n";
  formattedWord += "<p>" + word.sentence + "</p>";
  
  $('#messages').prepend(formattedWord);
})($)