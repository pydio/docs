During the full rewrite of the legacy Pydio8 (that used PHP) in the Go language, we put a strong focus on standards: all models have been described using protobuf and the API is fully described with a single swagger file.

As a result, clients in various languages can be easily generated, we already maintain SDKs in Go, Javascript and Java.

- [Cells Client](../cells-client/)
- [Cells SDK for Go](../cells-sdk-for-go/)
- [Cells SDK for JavaScript](../cells-sdk-for-javascript/)
- [Cells SDK for Java](../cells-sdk-for-java/)
