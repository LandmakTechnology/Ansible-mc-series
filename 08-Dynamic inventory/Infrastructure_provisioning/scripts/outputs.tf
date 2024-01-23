output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = [aws_instance.Kubernetes_Servers.*.public_ip, aws_instance.Kubernetes_Workers.*.public_ip, aws_instance.jenkins_worker.*.public_ip, aws_instance.sonarQube_worker.*.public_ip, aws_instance.nexus_worker.*.public_ip, aws_instance.tomcat_worker.*.public_ip, aws_instance.ansible_worker.*.public_ip]
}

