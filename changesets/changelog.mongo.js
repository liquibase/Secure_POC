// liquibase formatted mongodb

/*
    ********** Release 1.0.0 **********
*/
// changeset jbennett:create_collection_organizations labels:release-1.0.0
db.createCollection('Organizations', {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            title: "Organizations Validation",
            required: [ "_id", "name", "industry" ]
        }
    }
});
// rollback db.Organizations.drop()

// changeset jbennett:insert_many_organizations labels:release-1.0.0
db.Organizations.insertMany(
    [
        { _id: 1, name: "Acme Corporation", industry: "Explosives" },
        { _id: 2, name: "Initech", industry: "Y2K" },
        { _id: 3, name: "Umbrella Corporation", industry: "Zombies" },
        { _id: 4, name: "Soylent Corp", industry: "People" },
        { _id: 5, name: "Globex Corp", industry: "Widgets" }
    ]
);
// rollback db.Organizations.deleteMany({})

/*
    ********** Release 1.1.0 **********
*/

// db.createCollection('Addresses', {
//     validator: {
//         $jsonSchema: {
//             bsonType: "object",
//             title: "Addresses Validation",
//             required: [ "_id", "address", "city", "state", "zip" ]
//         }
//     }
// });

// changeset dzentgraf:create_collection_addresses labels:release-1.1.0
db.createCollection('Addresses');
// rollback db.Addresses.drop()

// changeset dzentgraf:insert_many_addresses labels:release-1.1.0
db.Addresses.insertMany(
    [
        { _id: 1, address: "7 Walt Whitman Street", city: "Gaithersburg", state: "MD", zip: "20877" },
        { _id: 2, address: "16 Manor Dr", city: "Dundalk", state: "CO", zip: "81222" },
        { _id: 3, address: "934 Trusel Avenue", city: "Bluffton", state: "SC", zip: "29910" },
        { _id: 4, address: "97 West Sierra Rd", city: "Stroudsburg", state: "PA", zip: "18360" },
        { _id: 5, address: "109 Queen St.", city: "Terre Haute", state: "IN", zip: "47802" },
    ]
);
// rollback db.Addresses.deleteMany({})

/*
    ********** Release 1.2.0 **********
*/
// changeset molivas:add_constraint_organizations labels:release-1.2.0
// Data fix: make sure all existing industries are valid
// db.Organizations.updateMany(
//     { industry: { $nin: ["Explosives", "Y2K", "Zombies", "People", "Widgets"] } },
//     { $set: { industry: "Unknown" } }
// );
// Now enforce constraint (safe - data is clean)
db.runCommand({
    collMod: "Organizations",
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["_id", "name", "industry"],
            properties: {
                _id: { bsonType: "int" },
                name: { bsonType: "string" },
                industry: { 
                    bsonType: "string",
                    enum: ["Explosives", "Y2K", "Zombies", "People", "Widgets", "Unknown"]
                }
            }
        }
    },
    validationLevel: "strict"  // Enforce on ALL updates - data is clean
});
// rollback db.runCommand({collMod: "Organizations", validator: {/* no constraint */}})