// liquibase formatted mongodb

// changeset jbennett:create_collection_organizations labels:release-1.0.0 runWith:mongosh
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

// changeset jbennett:insertmany_organizations labels:release-1.0.0 runWith:mongosh
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

// changeset jbennett:create_collection_addresses labels:release-1.1.0 runWith:mongosh
db.createCollection('Addresses');
// rollback db.Addresses.drop()

// changeset jbennett:insertmany_addresses labels:release-1.1.0 runWith:mongosh
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