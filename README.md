# Fandor Backend Coding Challenge

# API Routes:

## Films
### Index
GET api/films
### Show
GET api/films/:id

## Film Relations
### Create
POST api/film_relations
### Delete
DELETE api/film_relations  
(Film Relations use origin_film_id and related_film_id to find the relation to destroy)

### Data format for posting and deleting film relations
{  
&nbsp;&nbsp;film_relation: {  
&nbsp;&nbsp;&nbsp;&nbsp;origin_film_id: &lt;number>  
&nbsp;&nbsp;&nbsp;&nbsp;related_film_id: &lt;number>  
&nbsp;&nbsp;}  
}  

## Film Ratings
### Create
POST api/film_ratings
### Update
(Update methods use film_id and user_id to find the rating)  
PATCH api/film_ratings  
PUT api/film_ratings

### Data format for posting and patching a film rating
{  
&nbsp;&nbsp;film_rating: {  
&nbsp;&nbsp;&nbsp;&nbsp;rating: &lt;number>  
&nbsp;&nbsp;&nbsp;&nbsp;film_id: &lt;number>  
&nbsp;&nbsp;&nbsp;&nbsp;user_id: &lt;number>   
&nbsp;&nbsp;}  
}  


