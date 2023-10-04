## About
This is an app to find french recipes based on the ingredients (with or without). 

## User stories 
- As a user, i can search for recipes with an ingredient
- As a user, i can search for recipes with multiple ingredients
- As a user, i can search for recipes without specific ingredients (adding '-' or '!')

## Next possible steps : 
- Manage the misspelling :  
  - Add Elasticache or Algolia
- Change the query into a stimulus one : 
  - pros : smoother UX
  - cons : the DB may be overflooded by the calls, maybe send the request only when the spacebar is pressed
- Diversify the query :
  - which meal ? which timeframe ? which difficulty ?
- Access to the original website if the query returns nothing

