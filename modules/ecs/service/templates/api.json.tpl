[
  {
    "name": "${resource_prefix}-api",
    "image": "${api_docker_image}",
    "essential": true,
    "command": ["api"],
    "portMappings": [
      {
        "containerPort": ${container_port},
        "hostPort": ${host_port}
      }
    ],
    "memory": ${memory},
    "cpu": ${cpu},
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_logs_group}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "ecs"
      }
    },
    "environment": [
      {
        "name": "RDS_HOSTNAME",
        "value": "${rds_hostname}"
      },
      {
        "name": "RDS_PORT",
        "value": "${rds_port}"
      },
      {
        "name": "RDS_DB_NAME",
        "value": "${rds_db_name}"
      },
      {
        "name": "RDS_USERNAME",
        "value": "${rds_username}"
      },
      {
        "name": "RDS_PASSWORD",
        "value": "${rds_password}"
      },
      {
        "name": "APP_NAME",
        "value": "${app_name}"
      },
      {
        "name": "STAGE",
        "value": "${app_stage}"
      },
      {
        "name": "REDIS_URL",
        "value": "${redis_url}"
      }
    ]
  }
]
