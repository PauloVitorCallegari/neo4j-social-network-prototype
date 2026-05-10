CREATE CONSTRAINT user_id IF NOT EXISTS FOR (u:User) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT post_id IF NOT EXISTS FOR (p:Post) REQUIRE p.id IS UNIQUE;
CREATE CONSTRAINT tag_name IF NOT EXISTS FOR (t:Tag) REQUIRE t.name IS UNIQUE;


// Criando Usuários
MERGE (u1:User {id: 1, username: 'alice_data', name: 'Alice'})
MERGE (u2:User {id: 2, username: 'bob_dev', name: 'Bob'})
MERGE (u3:User {id: 3, username: 'carol_tech', name: 'Carol'})
MERGE (u4:User {id: 4, username: 'dave_sec', name: 'Dave'})

// Criando Relacionamentos de Seguidores
MERGE (u1)-[:FOLLOWS]->(u2)
MERGE (u2)-[:FOLLOWS]->(u1)
MERGE (u3)-[:FOLLOWS]->(u1)
MERGE (u4)-[:FOLLOWS]->(u2)
MERGE (u4)-[:FOLLOWS]->(u3)

// Criando Posts e Tags
MERGE (t1:Tag {name: 'Neo4j'})
MERGE (t2:Tag {name: 'DataScience'})
MERGE (t3:Tag {name: 'GraphDB'})

MERGE (p1:Post {id: 101, content: 'Aprendendo modelagem de grafos!', date: '2026-05-10'})
MERGE (u1)-[:POSTED]->(p1)
MERGE (p1)-[:HAS_TAG]->(t1)
MERGE (p1)-[:HAS_TAG]->(t3)

MERGE (p2:Post {id: 102, content: 'Bancos relacionais vs NoSQL', date: '2026-05-11'})
MERGE (u2)-[:POSTED]->(p2)
MERGE (p2)-[:HAS_TAG]->(t2)

MERGE (p3:Post {id: 103, content: 'O poder das queries Cypher.', date: '2026-05-12'})
MERGE (u3)-[:POSTED]->(p3)
MERGE (p3)-[:HAS_TAG]->(t1)

// Criando Interações (Likes)
MERGE (u2)-[:LIKED]->(p1)
MERGE (u3)-[:LIKED]->(p1)
MERGE (u4)-[:LIKED]->(p1)
MERGE (u1)-[:LIKED]->(p2)
MERGE (u4)-[:LIKED]->(p3)