variable "project" {
    description = "Project"
    default = "project-f4bad27f-8327-43c7-b26"
}

variable "location" {
    description = "Project Location"
    default = "EUROPE-WEST9"
}

variable "bq_dataset_name" {
    description = "My BigQuery dataset name"
    default = "demo_dataset"
}

variable "gcs_bucket_name" {
    description = "My storage bucket name"
    default = "project-f4bad27f-8327-43c7-b26-terra-bucket"
}

variable "gcs_storage_class" {
    description = "Bucket Storage Class"
    default = "STANDARD"
}
