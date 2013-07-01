# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

my_function = (param) ->
  "return of my_function with parameter: #{param}"

@return_div_html = () ->
  alert(div.innerHTML) for div in $("div")

###
for a in [1..10] by 1
  break if a is 5
  continue if a is 2
  alert("Namber a=#{a}")

alert("After loop")
alert(my_function("Nazik_Parameter"))
###

###
array = ["Hello", "Nazar"]
alert(array[1])
alert(array.length)
alert(array.reverse())
alert(array.join())
###

#Object
@player =
  player_name: "Nazar"
  player_score: 10000
  player_rank: 1
  information: () ->
    alert("Player Name: #{@.player_name}, Player Score: #{@.player_score}, Player Rank: #{@.player_rank}")

class Person
  constructor: (@first_name, @last_name) ->
    #do nothing

  get_name: () =>
    alert("Name of this person is: #{@.first_name} #{@.last_name}")

@create_person = (f_name, l_name) ->
  ni = new Person(f_name, l_name);
  ni.get_name()

@work_with_dom = () ->
  div = document.getElementById("someContent")
  div.setAttribute("align", "right")
  
  p = document.createElement("p")
  p_text = document.createTextNode("Newly created text")
  p.appendChild(p_text)
  div.appendChild(p)
  
  mainTitle = document.getElementById("mainTitle")
  mainTitle.innerHTML = "Changed Title"
  #alert("This is an element of type: #{mainTitle.nodeType}\nThe inner Html is: #{mainTitle.innerHTML}\nNumber of child nodes: #{mainTitle.childNodes.length}")




