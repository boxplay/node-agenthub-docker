module.exports = {
    apps: [{
        name: "landapi",
        script: "./dist/main.js",
        watch: true,
        env_dev: {
            "PORT": 3008,
            "NODE_ENV": "dev",
            "ENABLE_NODE_LOG": "YES",
            "NODE_LOG_DIR": "/tmp"
        },
        env_prod: {
            "PORT": 80,
            "NODE_ENV": "prod",
            "ENABLE_NODE_LOG": "YES",
            "NODE_LOG_DIR": "/tmp"
        },
        env_local: {
            "PORT": 3008,
            "NODE_ENV": "local",
            "ENABLE_NODE_LOG": "YES",
            "NODE_LOG_DIR": "/tmp"
        },
        env_test: {
            "PORT": 3008,
            "NODE_ENV": "dev",
            "ENABLE_NODE_LOG": "YES",
            "NODE_LOG_DIR": "/tmp"
        },
    }]
}