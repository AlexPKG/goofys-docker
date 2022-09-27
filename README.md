# Goofys in Docker

A multiarch image to mount an S3 Bucket as a FUSE filesystem Based on Goofys with catfs for caching

This image is intended to be a drop-in replacement for mephistoxol/s3fs and ikarpovich/s3fs
### Environment Variables

| Env. Variable | Description                    |
| ------------- |--------------------------------| 
| S3_BUCKET     | S3 Bucket Name                 |
| S3_URL        | S3 EndPoint like minio, aws... |
| OPTION        | Additional options for Goofys  |

### Install

S3 Credentials should be passed as env variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY .
Please, use secrets for this