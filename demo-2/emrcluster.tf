resource "aws_emr_cluster" "emr-spark-cluster" {
   name = "EMR-cluster-for-bigdata"
   release_label = "emr-5.32.0"
   applications = ["Ganglia", "Spark", "Zeppelin", "Hive", "Hue","Livy"]
 
   ec2_attributes {
     instance_profile = "${aws_iam_instance_profile.emr_profile.arn}"
     key_name = aws_key_pair.mykey.key_name
     subnet_id = aws_subnet.public-subnet.id
     emr_managed_master_security_group = "${aws_security_group.master_security_group.id}"
     emr_managed_slave_security_group = "${aws_security_group.slave_security_group.id}"
   }
 
    master_instance_group {
    instance_type = "m5.xlarge"
  }

  core_instance_group {
    instance_type  = "m5.xlarge"
    instance_count = 1
  }
 
   log_uri = "s3://${aws_s3_bucket.logging_bucket.bucket}"
 
   tags ={
     name = "EMR-cluster"
     role = "EMR_DefaultRole"
   }
 
  service_role = "${aws_iam_role.spark_emr_cluster_service_role.arn}"
}