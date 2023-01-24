cluster_name="kubeflow-synth-chm-v3"
cluster_region="us-east-1"
generate_db_password="true"
use_rds="true"
use_s3="true"

# The below values are set to make cleanup easier but are not recommended for production
deletion_protection="false"
secret_recovery_window_in_days="0"
force_destroy_s3_bucket="true"
