// Ejercicio 1


db.listingsAndReviews.aggregate([
    {
        $group: {
            "_id": "$address.country",
            "prom": {$avg: "$review_scores.review_scores_rating"},
            "cantidad": {$sum: 1}
        }
    },
    {
        $project: {
            "_id": 0,
            "pais": "$_id",
            "rating promedio": "$prom",
            "cantidad de rating": "$cantidad"
        }
    },
    {
        $sort: {"rating promedio": -1}
    }
])


// Ejercicio 2
db.listingsAndReviews.aggregate([
    {
        $match: {
            "reviews.0": {$exists: true}
        }
    },
    {
        $addFields: {
            "review_mas_reciente": {$max: "$reviews.date"}
        }
    },
    {
        $sort: {
            "review_mas_reciente": - 1
        }
    },
    {
        $project: {
            "_id": 1,
            "name": 1,
            "review_mas_reciente": 1,
            "cantidad_de_reviews": {$size: "$reviews"}
        }
    },
    {
        $limit: 20
    }
])


// Ejercicio 3

db.createView(
    "top_10_most_common_amenities",
    "listingsAndReviews",
    [
        {
            $unwind: "$amenities"
        },
        {
            $group: {
                "_id": "$amenities",
                "ocurrencias": {$sum: 1}
            }
        },
        {
            $project: {
                "_id": 0,
                "amenitie": "$_id",
                "ocurrencias": 1
            }
        },
        {
            $sort: {
                "ocurrencias": -1
            }
        }
    ]
)


// Ejercicio 4

db.listingsAndReviews.updateMany(
    {"address.country": "Brazil",
     "review_scores.review_scores_rating": {$exists: true}},
    [
        {
            $set: {
                quality_level: {
                    $switch: {
                        branches: [
                            {
                                case: {$gte: ["$review_scores.review_scores_rating", 90]},
                                then: "High"
                            },
                            {
                                case: {
                                    $and: [{$gte: ["$review_scores.review_scores_rating", 70]},
                                            {$lt: ["$review_scores.review_scores_rating", 90]}]
                                },
                                then: "Medium"
                            }
                        ],
                        default: "Low"
                    }
                }
            }
        }
    ]
)


// Ejercicio 5 a 

db.runCommand({
    collMod: "listingsAndReviews",
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["name", "address", "amenities", "review_scores", "reviews"],
            properties: {
                "name": { bsonType: "string"},
                "address": {
                    bsonType: "object",
                    required: ["street", "suburb", "government_area", "market", "country", "country_code", "location"],
                    properties: {
                        street: {bsonType: "string"},
                        suburb: {bsonType: "string"},
                        "government_area": {bsonType: "string"},
                        "market": {bsonType: "string"},
                        "country": {bsonType: "string"},
                        "country_code": {bsonType: "string"},
                        "location": {
                            bsonType: "object",
                        }
                    }
                },
                "amenities": {
                    bsonType: "array", 
                    items: {
                        bsonType: "string"
                    }
                },
                "review_scores": {
                    bsonType: "object"
                },
                "reviews": {
                    bsonType: "array",
                    items: {
                        bsonType: "object"
                    }
                }
            }
        }
    }
})


// Ejercicio 5b

db.listingsAndReviews.insertOne({
    "name": "Salsipuedes",
    "address": {
        "street": "chacabuco",
        "suburb": "colon",
        "government_area": 99,
        "market": "ni idea",
        "country": "argentina",
        "country_code": "AR",
        "location": {
        }
    },
    "amenities": [
        "bonito"
    ],
    "review_scores": {

    },
    "reviews": []
})

// Falla porque government_area deberia ser un string



db.listingsAndReviews.insertOne({
    "name": "Salsipuedes",
    "address": {
        "street": "chacabuco",
        "suburb": "colon",
        "government_area": "ni idea",
        "market": "ni idea",
        "country": "argentina",
        "country_code": "AR",
        "location": {
        }
    },
    "amenities": [
        "bonito"
    ],
    "review_scores": {

    },
    "reviews": {

    }
})


// Falla porque reviews deberia ser un array 


db.listingsAndReviews.insertOne({
    "name": "Salsipuedes",
    "address": {
        "street": "chacabuco",
        "suburb": "colon",
        "government_area": "ni idea",
        "market": "ni idea",
        "country": "argentina",
        "country_code": "AR",
        "location": {
        }
    },
    "amenities": [
        "bonito"
    ],
    "review_scores": {

    },
    "reviews": []
})

// Funciona correctamente


