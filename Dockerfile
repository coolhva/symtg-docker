# Docker file for Symantec Traffig Generator for WSS
# Author: Henk van Achterberg (henk_vanachterberg@symantec.com)

# Retrieve basic alpine linux image
FROM alpine

# Set the working directory to /app
WORKDIR /app

# Copy the files into the container at /app
COPY urllist.txt.enc /app
COPY wss.sh /app
COPY startup.sh /app
COPY motd.txt /app
COPY update.sh /app

# Install Tini
RUN apk add --no-cache tini

# Install curl
RUN apk --no-cache add curl

# Install openssl
RUN apk --no-cache add openssl

# Install git
RUN apk --no-cache add git

# Run app.py when the container launches
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/bin/sh", "/app/startup.sh"]
