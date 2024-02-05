ENDPOINT = http://localhost:8000
TAR_URL = https://d1ni2b6xgvw0s0.cloudfront.net/v2.x/dynamodb_local_latest.tar.gz
TBL_NAME = metadata

attrs = $(call fld_,t_name,S) $(call fld_,timestamp,N)
schema = $(call key_,t_name,HASH) $(call key_,timestamp,RANGE)

# macros
fld_ = AttributeName=$1,AttributeType=$2
key_ = AttributeName=$1,KeyType=$2


dynamodb: db/DynamoDBLocal.jar | db/DynamoDBLocal_lib
	cd db; \
	java -Djava.library.path=DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb

%/DynamoDBLocal_lib: %/DynamoDBLocal.jar

%/DynamoDBLocal.jar:
	mkdir -p $*; cd $*; \
	wget -c $(TAR_URL); \
	tar -zxf *.tar.gz

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
	aws dynamodb describe-table \
		--endpoint-url $(ENDPOINT) \
		--table-name $(TBL_NAME)

scan:
	aws dynamodb scan \
		--endpoint-url $(ENDPOINT) \
		--table-name $(TBL_NAME)
