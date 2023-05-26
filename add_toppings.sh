#!/bin/bash

url="http://localhost:8080/toppings"
total_requests=10000

toppings=(
  "Pepperoni"
  "Mushrooms"
  "Sausage"
  "Onions"
  "Bacon"
  "Extra cheese"
  "Black olives"
  "Green peppers"
  "Pineapple"
  "Spinach"
  "Jalapeños"
  "Ham"
  "Anchovies"
  "Tomatoes"
  "Garlic"
  "Basil"
  "Bell peppers"
  "Italian sausage"
  "Feta cheese"
  "Chicken"
  "Red onions"
  "Fresh mozzarella"
  "Sun-dried tomatoes"
  "Artichoke hearts"
  "Provolone cheese"
  "Salami"
  "Cheddar cheese"
  "Goat cheese"
  "Gorgonzola cheese"
  "Ricotta cheese"
  "Parmesan cheese"
  "Canadian bacon"
  "Barbecue sauce"
  "Sweet corn"
  "BBQ chicken"
  "Caramelized onions"
  "Kalamata olives"
  "Fresh basil"
  "Pesto"
  "Pepperoncini"
  "Capers"
  "Arugula"
  "Bleu cheese"
  "Sriracha sauce"
  "Buffalo chicken"
  "Roasted red peppers"
  "Balsamic glaze"
  "Shrimp"
  "Clams"
  "Scallions"
  "Tuna"
  "Corned beef"
  "Beef"
  "Fresh tomatoes"
  "Cilantro"
  "Avocado"
  "Pine nuts"
  "Gouda cheese"
  "Chipotle sauce"
  "Goat pepperoni"
  "Oregano"
  "Sundried tomatoes"
  "Ricotta spinach"
  "Mozzarella sticks"
  "Ranch dressing"
  "Pepperoni cups"
  "Sunflower seeds"
  "Green olives"
  "Andouille sausage"
  "Blue cheese crumbles"
  "Smoked salmon"
  "Rosemary"
  "Ricotta salata"
  "Fried egg"
  "Caramelized apples"
  "Cinnamon sugar"
  "Brie cheese"
  "Pancetta"
  "Pesto chicken"
  "Fig jam"
  "Sliced almonds"
  "Cranberry sauce"
  "Honey"
  "Pickled jalapeños"
  "Fried onions"
  "Tzatziki sauce"
  "Prosciutto"
  "Roasted garlic"
  "Dill"
  "Italian herbs"
  "Truffle oil"
  "Pecorino cheese"
  "Gruyère cheese"
  "Fig balsamic glaze"
  "Pistachios"
  "Basil pesto chicken"
  "Fennel sausage"
  "Ricotta provolone blend"
  "Red pepper flakes"
  "Fresh mint leaves"
)

function getRandomTopping() {
  local random_index=$(( RANDOM % ${#toppings[@]} ))
  local random_topping="${toppings[random_index]}"
  printf "%s" "$random_topping"
}

function getRandomToppings() {
  local num_times=$(( RANDOM % 10 + 1 ))
  local toppings_list=""

  for (( i=1; i<=num_times; i++ )); do
    local random_topping=$(getRandomTopping)
    if [[ $toppings_list ]]; then
      toppings_list+=",$random_topping"
    else
      toppings_list=$random_topping
    fi
  done

  printf "%s" "$toppings_list"
}

function getRandomEmail() {
  local email="email_$(( RANDOM % total_requests*3))@somemailbox.com"
  printf "%s" "$email"
}

function generatePayload() {
  local email=$(getRandomEmail)
  local payload="{ \"email\": \"$email\", \"toppingsContent\": \"$(getRandomToppings)\" }"
  printf "%s" "$payload"
}

for ((i = 1; i <= total_requests; i++)); do
  payload=$(generatePayload)
  printf "Sending POST request %d, %s...\n" "$i" "$payload"
  response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/json" -d "$payload" "$url")

  if [[ $response -ne 200 ]]; then
    printf "Request failed with status code %s\n" "$response"
  fi
done