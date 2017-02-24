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

### Data format for posting and deleting film relations
{  
    film_relation: {  
        origin_film_id: &lt;number>  
        related_film_id: &lt;number>  
    }  
}  

## Film Ratings
### Create
POST api/film_ratings
### Update
PATCH api/film_ratings/:id  
PUT api/film_ratings/:id

### Data format for posting and patching a film rating
{  
    film_rating: {  
        rating: &lt;number>  
        film_id: &lt;number>  
        user_id: &lt;number>   
    }  
}  


