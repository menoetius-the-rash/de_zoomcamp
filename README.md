# Datatalks Data Engineering Zoomcamp
This is a repo created to follow and learn data engineering with practical work

# connect to the service-account
gcloud auth application-default login

# initialize terraform and configuration
terraform init

# Check for changes
terraform plan -var="project=<your-gcp-project-id>"

# Apply the changes found
terraform apply -var="project=<your-gcp-project-id>"

# Delete your terraform work to avoid incurring costs on your cloud project very important
terraform destroy