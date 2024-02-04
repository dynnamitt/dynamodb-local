ENDPOINT = http://localhost:8000
TBL_NAME = metadata

attrs = $(call fld_,t_name,S) $(call fld_,timestamp,N)
schema = $(call key_,t_name,HASH) $(call key_,timestamp,RANGE)

# macros
fld_ = AttributeName=$1,AttributeType=$2
key_ = AttributeName=$1,KeyType=$2


dynamodb: DynamoDBLocal.jar | DynamoDBLocal_lib/
	java -Djava.library.path=$| -jar $< -sharedDb

create:
	aws dynamodb create-table \
		--endpoint-url $(ENDPOINT) \
		--table-name $(TBL_NAME) \
		--billing-mode PAY_PER_REQUEST \
		--attribute-definitions $(attrs) \
		--key-schema $(schema)

delete:
	aws dynamodb delete-table \
		--endpoint-url $(ENDPOINT) \
		--table-name $(TBL_NAME)

list:
	aws dynamodb list-tables \
		--endpoint-url $(ENDPOINT)

scan:
	aws dynamodb scan \
		--endpoint-url $(ENDPOINT) \
		--table-name $(TBL_NAME)
