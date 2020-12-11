url = https://db-pedro-gutierrez.cloud.okteto.net
#url = http://localhost:8080

start:
	@docker run --rm -it -p 8080:8080 -p 9080:9080 -p 8000:8000 -e DGRAPH_ALPHA_GRAPHQL_EXTENSIONS=false -v $(PWD)/data:/dgraph dgraph/standalone:v20.07.2 

schema:
	@curl -X POST $(url)/admin/schema --data-binary '@schema.graphql'

add-products:
	@curl -H "Content-Type: application/graphql" -X POST $(url)/graphql -d @add-products.graphql | jq

add-review:
	@curl -H "Content-Type: application/graphql" -X POST $(url)/graphql -d @add-review.graphql | jq

query-reviews:
	@curl -H "Content-Type: application/graphql" -X POST $(url)/graphql -d @query-reviews.graphql | jq
