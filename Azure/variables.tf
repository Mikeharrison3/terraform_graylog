variable deployment_environment {
    description = "The deployment environment. Can be DEV TEST PROD"
    type = string
}

variable environment_settings {
    type = map(object({instance_type=string, test=bool}))
    description = "Monitoring Settings"

    default = {
        "DEV" = {
            instance_type = "t2.micro"
            test = false
        },
        "TEST" = {
            instance_type = "t2.micro"
            test = true
        },
        "PROD" = {
            instance_type = "t2.micro"
            test = false
        }
    }
}