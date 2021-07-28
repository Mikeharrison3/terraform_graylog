output "server_public_ip" {
    value = aws_instance.graylog-server.public_ip
}

