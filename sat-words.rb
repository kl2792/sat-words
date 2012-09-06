require 'sinatra'
require 'csv'

get '/' do
  csv = CSV.open('words.csv')
  today = Date.today.strftime('%m/%d/%y')
  @word = csv.find {|word| word[0] === "09/06/12"}
  
  erb :index
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