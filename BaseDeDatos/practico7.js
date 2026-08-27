db.users.insertMany([
    {"name": 'Emiliano Gonzalez', "email": 'emiliano.gonzalez1169@mi.unc.edu.ar',
    "password": 'warhammer'},
    {"name": 'Santos Farias', "email": 'Santos.farias@mi.unc.edu.ar',
    "password": 'Cs'},
    {"name": 'Santino Ponchiardi', "email": 'santino.ponchiardi@mi.unc.edu.ar',
    "password": 'warthunder'},
    {"name": 'Alejandro Pitt', "email": 'Alejandro.Pitt@mi.unc.edu.ar',
    "password": 'sudoku'},
    {"name": 'Mauro Salman', "email": 'mauro.salman@mi.unc.edu.ar',
    "password": 'Mu'},
])

// Ejercicio 2


db.movies.find(
    {$and: [{"year":{$gt: 1989}}, {"year": {$lt: 2000}}, {"imdb.rating": {$type: "double"}}]},
    {"title": 1, "year": 1, "cast": 1, "directors": 1, "imdb.rating": 1}
).sort({"imdb.rating": -1}
    ).limit(10)

//Ejercicio 3
// Listar el nombre, email, texto y fecha de los comentarios que la película con 
// id (movie_id) ObjectId("573a1399f29313caabcee886") recibió entre los años 
// 2014 y 2016 inclusive. Listar ordenados por fecha. Escribir una nueva consulta 
// (modificando la anterior) para responder ¿Cuántos comentarios recibió?

db.comments.find(
    {"movie_id": ObjectId("573a1399f29313caabcee886"),
     "date": {$gte: ISODate("2014-01-01T00:00:00Z"),
                $lte: ISODate("2016-12-31T23:59:59Z")},
    }
).sort({"date": -1}
).count()

//Ejercicio 4
 
// Listar el nombre, id de la película, texto y fecha de los 3 comentarios
// más recientes realizados por el usuario con email patricia_good@fakegmail.com.

db.comments.find(
    {"email": "patricia_good@fakegmail.com"},
    {"name": 1, "movie_id": 1, "text": 1, "date": 1}
).sort({"date": -1}
).limit(3)

//Ejercicio 5
//
//Listar el título, idiomas (languages), géneros, fecha de lanzamiento (released)
//y número de votos (“imdb.votes”) de las películas de géneros Drama y Action 
//(la película puede tener otros géneros adicionales), que solo están disponibles 
//en un único idioma y por último tengan un rating (“imdb.rating”) mayor a 
//9 o bien tengan una duración (runtime) de al menos 180 minutos. Listar ordenados 
//por fecha de lanzamiento y número de votos

db.movies.find(
    {"genres":{$all : ['Drama', 'Action']},
     "languages": {$size: 1},
     $or: [{"imdb.rating": {$gt: 9}},{"runtime": {$gte: 180}}]},
    {"title": 1, "countries": 1, "genre": 1, "year": 1, "imdb.votes": 1}
).sort({"year": 1,
        "imdb.votes": - 1})

//Ejercicio 6 
//Listar el id del teatro (theaterId), estado (“location.address.state”), 
//ciudad (“location.address.city”), y coordenadas (“location.geo.coordinates”) 
//de los teatros que se encuentran en algunos de los estados "CA", "NY", "TX" 
//y el nombre de la ciudades comienza con una ‘F’. Listar ordenados por estado 
//y ciudad.


db.theaters.find(
    {"location.address.state": {$in : ["CA", "NY", "TX"]},
     "location.address.city": {$regex: '^F'}},
    {"theaterId": 1,
        "location.address.state": 1,
        "location.address.city": 1,
        "location.geo.coordinates": 1}
).sort({"location.address.state": 1,
        "location.address.city": 1})

//Ejercicio 7
//Actualizar los valores de los campos texto (text) y fecha (date) del 
//comentario cuyo id es ObjectId("5b72236520a3277c015b3b73") a "mi mejor comentario" 
//y fecha actual respectivamente.

db.comments.updateOne(
    {"_id": ObjectId("5b72236520a3277c015b3b73")},
    {
        $set: {"text": "mi mejor comentario"},
        $currentDate: {
            "date": true
        }
    }
)

//Ejercicio 8 
//Actualizar el valor de la contraseña del usuario cuyo email es 
//joel.macdonel@fakegmail.com a "some password". La misma consulta debe 
//poder insertar un nuevo usuario en caso que el usuario no exista. 
//Ejecute la consulta dos veces. ¿Qué operación se realiza en cada caso?  
//(Hint: usar upserts).

db.users.updateOne(
    {
        "email": "joel.macdonel@fakegmail.com"
    },
    {
        $set: {"password": "some password"}
    },
    {
        upsert: true 
    }
)

//Ejercicio 9 
//Remover todos los comentarios realizados por el usuario cuyo email es 
//victor_patel@fakegmail.com durante el año 1980.
 

db.comments.deleteMany(
    {
        "email": "victor_patel@fakegmail.com",
        "date": {
            $gte: ISODate("1980-01-01T00:00:00Z"),
            $lte: ISODate("1980-12-31T23:59:59")
        }
    }
)




// PARTE 2 
// Ejercicio 10
// Listar el id del restaurante (restaurant_id) y las calificaciones 
// de los restaurantes donde al menos una de sus calificaciones haya sido 
// realizada entre 2014 y 2015 inclusive, y que tenga una puntuación (score) 
// mayor a 70 y menor o igual a 90.

db.restaurants.find(
    {
        "grades" : {
            $elemMatch: {
                "date": {$gte: ISODate("2014-01-01T00:00:00Z"),
                         $lt: ISODate("2016-01-01T00:00:00Z")},
                "score": {
                    $gt: 70,
                    $lte: 90
                }
            }
        }
    },
    {
        "restaurant_id": 1, "grades.score": 1
    }
)

// Ejercicio 11
// Agregar dos nuevas calificaciones al restaurante cuyo id es "50018608". 
// A continuación se especifican las calificaciones a agregar en una sola consulta.  

db.restaurants.updateOne(
    {
        "restaurant_id": "50018608"
    },
    {
        $addToSet: {
            "grades": {
                $each: [
                        {
                            "date" : ISODate("2019-10-10T00:00:00Z"),
                            "grade" : "A",
                            "score" : 18
                        },
                        {
                            "date" : ISODate("2020-02-25T00:00:00Z"),
                            "grade" : "A",
                            "score" : 21
                        }
                        ]
            }
        }
    }
)


//Practico 8



// Ejercicio 1 
// Cantidad de cines (theaters) por estado.


db.theaters.aggregate(
    {
        $group: {
            "_id": "$location.address.state",
            "total": {$sum: 1}
        }
    }
).toArray()

// Ahí está el problema! Cuando usas comillas sin $, MongoDB 
// lo interpreta como un string literal, no como una referencia al campo.
//
//
//    Sin .toArray(): MongoDB muestra solo los primeros 20 documentos 
//    (límite por defecto en shell/Compass)

//    Con .toArray(): Fuerza a cargar y mostrar TODOS los documentos 
//    del cursor

// Ejercicio 2 
// Cantidad de estados con al menos dos cines (theaters) registrados.

db.theaters.aggregate([
    {
        $group: {
            "_id": "$location.address.state",
            "cantidad": {$sum: 1}
        }
    },
    {
        $match: {
            "cantidad": {$gte: 2}
        }
    },
    {
        $count: "Estados con al menos 2 cines"
    }
])

// Ejercicio 3
// Cantidad de películas dirigidas por "Louis Lumière". Se puede 
// responder sin pipeline de agregación, realizar ambas queries


db.movies.aggregate([
    {
        $match: {
            "directors": {$in: ["Louis Lumière"]}
        }
    },
    {
        $count: "Cantidad de peliculas"
    }
]).toArray()

db.movies.find(
    {
        "directors": {$in: ["Louis Lumière"]}
    }
).count()


db.movies.find(
    {
        "directors": "Louis Lumière"
    }
).count()

// Ejercicio 4
// Cantidad de películas estrenadas en los años 50 (desde 1950 
// hasta 1959). Se puede responder sin pipeline de agregación, 
// realizar ambas queries.

db.movies.aggregate([
    {
        $match: {
            "year": {$gte: 1950, $lt: 1960}
        }
    },
    {
        $count: "peliculas de los 50"
    }
])

db.movies.find(
    {
        "year": {$gte: 1950, $lt: 1960}
    }
).count()

// Ejercicio 5
// Listar los 10 géneros con mayor cantidad de películas 
// (tener en cuenta que las películas pueden tener más de un 
// género). Devolver el género y la cantidad de películas. 
// Hint: unwind puede ser de utilidad


db.movies.aggregate([
    {
        $unwind: "$genres"
    },
    {
        $group: {
            "_id": "$genres",
            "cant": {$sum: 1}
        }
    },
    {
        $sort: {
            "cant": - 1
        }
    },
    {
        $limit: 10
    }
])

// Ejercicio 6 
// Top 10 de usuarios con mayor cantidad de comentarios, 
// mostrando Nombre, Email y Cantidad de Comentarios.

db.comments.aggregate()

// Ejercicio 9
// Crear una vista con los 5 géneros con mayor cantidad de 
// comentarios, junto con la cantidad de comentarios.

db.createView(
    "generos",
    "movies",
    [
        {
            $unwind: "$genres"
        },
        {
            $lookup: {
                from: "comments",
                localField: "_id",
                foreignField: "movie_id",
                as: "comentarios"
            }
        },
        {
            $project: {
                "genres": 1,
                "cant": {$size: "$comentarios"}
            }
        },
        {
            $sort: {"cant": - 1}
        },
        {
            $limit: 5
        }
    ]
)


// mflix> db.getCollection("5generos").drop()
// true
// mflix> db.getCollection("5 generos").drop()
// true
// mflix> db.getCollection("generos").drop()
// true
// mflix> db.getCollection("generos").drop()

// Ejercicio 10
//
// Listar los actores (cast) que trabajaron en 2 o más películas 
// dirigidas por "Jules Bass". Devolver el nombre de estos actores junto 
// con la lista de películas (solo título y año) dirigidas por 
// “Jules Bass” en las que trabajaron. 


db.movies.aggregate([
    {
        $match: {
            "directors": "Jules Bass"
        }
    },
    {
        $unwind: "$cast"
    },
    {
        $group: {
            "_id": "$cast",
            "pelicula": {
                $addToSet: {
                    "titulo": "$title",
                    "año": "$year"
                }
            }
        }
    },
    {
        $match: {
            "pelicula.1": {$exists: true}
        }
    }
])



// Ejercicio 11
// Listar los usuarios que realizaron comentarios durante el mismo 
// mes de lanzamiento de la película comentada, mostrando Nombre, 
// Email, fecha del comentario, título de la película, fecha de lanzamiento
// . HINT: usar $lookup con multiple condiciones
//



db.comments.aggregate([
    {
        $lookup: {
            from: "movies",
            let: {
                "movie_id": "$movie_id",
                "comment_year": {$year: "$date"}
            },
            pipeline: [
                {
                    $match: {
                        $expr: {
                            $and: [
                                {$eq: ["$_id", "$$movie_id"]},
                                {$eq: ["$year", "$$comment_year"]},
                            ]
                        }
                    }
                }
            ],
            as: "peliculas"
        }
    },{
        $match: {
            "peliculas.0": {$exists: true}
        }
    },{
        $project: {
            "name": 1,
            "email": 1,
            "date": 1,
            "pelicula_titulo" : "$peliculas.title",
            "peliculas.year": 1
        }
    }
])




db.comments.aggregate([
    {
        $lookup: {
            from: "movies",
            let: {
                "movie_id": "$movie_id",
                "comment_year": {$year: "$date"}
            },
            pipeline: [
                {
                    $match: {
                        $expr: {
                            $and: [
                                {$eq: ["$_id", "$$movie_id"]},
                                {$eq: ["$year", "$$comment_year"]},
                            ]
                        }
                    }
                }
            ],
            as: "peliculas"
        }
    },{
        $match: {
            "peliculas.0": {$exists: true}
        }
    },{
        $unwind: "$peliculas"
    },{
        $project: {
            "name": 1,
            "email": 1,
            "date": 1,
            "titulo_pelicula": "$peliculas.title",
            "pelicula_year": "peliculas.year"
        }
    }
])

// es casi lo mismo 













