FROM ghcr.io/terraform-linters/tflint

COPY .tflint.hcl /data

RUN tflint --init
