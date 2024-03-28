server {
	listen 80 default_server;
	listen [::]:80 default_server;

	server_name example.com;

	root /var/www/example.com/html;
	index index.html;

	location / {
		try_files $uri $uri/ =404;
	}
}
