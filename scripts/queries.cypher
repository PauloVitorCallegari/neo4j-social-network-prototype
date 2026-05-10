
// Pergunta 1: Popularidade de Conteúdo
// "Quais são os posts com maior engajamento (mais curtidas) e quem é o autor?"
MATCH (author:User)-[:POSTED]->(p:Post)<-[l:LIKED]-(liker:User)
RETURN p.content AS Postagem, author.name AS Autor, count(l) AS Total_Likes
ORDER BY Total_Likes DESC
LIMIT 5;


// Pergunta 2: Recomendação e Interações (Graus de Separação)
// "Quais posts os usuários que a Alice segue estão curtindo? (Recomendação de conteúdo no feed)"
MATCH (u:User {username: 'alice_data'})-[:FOLLOWS]->(friend:User)-[:LIKED]->(p:Post)
RETURN friend.name AS Amigo, p.content AS Post_Recomendado;

// Pergunta 3: Comunidades de Interesse
// Quais usuários estão indiretamente conectados por terem curtido posts com a mesma Tag (ex: 'Neo4j')?
MATCH (u1:User)-[:LIKED]->(p1:Post)-[:HAS_TAG]->(t:Tag {name: 'Neo4j'})
MATCH (u2:User)-[:LIKED]->(p2:Post)-[:HAS_TAG]->(t)
WHERE u1 <> u2 AND NOT (u1)-[:FOLLOWS]-(u2)
RETURN u1.name AS Usuario_A, u2.name AS Usuario_B, t.name AS Interesse_Comum;