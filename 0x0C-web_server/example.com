server {
	listen 80 default_server;
	listen [::]:80 default_server;

	server_name web_01.com;

	root /var/www/web_01.com/html;
	index index.html;

	location / {
		try_files $uri $uri/ =404;
	}
}
