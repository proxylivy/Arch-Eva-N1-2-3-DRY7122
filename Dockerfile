FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 9999
CMD ["nginx", "-g", "daemon off;"]